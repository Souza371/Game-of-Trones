import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

// Simple image proxy & cache to bypass CORS restrictions for Flutter Web.
// Usage:
//   dart run bin/main.dart --port 8081
// Fetch image:
//   http://localhost:8081/image?url=<ENCODED_URL>
// After first fetch cached file served at /cached/<hash>.<ext>

Future<void> main(List<String> args) async {
  final port = _readArg(args, '--port') != null ? int.parse(_readArg(args, '--port')!) : 8081;
  final cacheDir = Directory('cache');
  if (!cacheDir.existsSync()) cacheDir.createSync(recursive: true);

  final router = Router();

  // Health check
  router.get('/health', (Request req) => Response.ok('OK'));

  // Proxy endpoint
  router.get('/image', (Request req) async {
    final raw = req.requestedUri.queryParameters['url'];
    if (raw == null || raw.isEmpty) {
      return Response(400, body: 'Missing url parameter');
    }
    final decoded = Uri.decodeFull(raw);

    // Hash file name
    final hash = md5.convert(utf8.encode(decoded)).toString();
    final uri = Uri.parse(decoded);
    final ext = p.extension(uri.path).replaceAll('.', '').toLowerCase();
    final safeExt = (ext.isEmpty || ext.length > 5) ? 'img' : ext; // fallback
    final file = File(p.join(cacheDir.path, '$hash.$safeExt'));

    if (file.existsSync()) {
      return _serveFile(file);
    }

    try {
      final client = http.Client();
      final resp = await client.get(uri, headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36',
        'Accept': 'image/avif,image/webp,image/apng,image/*,*/*;q=0.8'
      });
      client.close();

      if (resp.statusCode != 200) {
        return Response(resp.statusCode, body: 'Upstream error ${resp.statusCode}');
      }

      file.writeAsBytesSync(resp.bodyBytes, flush: true);
      return _serveFile(file);
    } catch (e) {
      return Response.internalServerError(body: 'Fetch error: $e');
    }
  });

  // Expose cached files statically
  final staticHandler = createStaticHandler('cache', listDirectories: false, serveFilesOutsidePath: false);
  router.get('/cached/<file|.*>', (Request req) {
    final path = req.params['file'];
    if (path == null) return Response.notFound('Not found');
    final file = File('cache/$path');
    if (!file.existsSync()) return Response.notFound('Not found');
    return _serveFile(file);
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_cors())
      .addHandler(router);

  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('Image proxy listening on port ${server.port}');
}

Middleware _cors() {
  return (inner) {
    return (Request req) async {
      final resp = await inner(req);
      return resp.change(headers: {
        ...resp.headers,
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Origin, Accept'
      });
    };
  };
}

Response _serveFile(File f) {
  final bytes = f.readAsBytesSync();
  final mime = lookupMimeType(f.path) ?? 'application/octet-stream';
  return Response.ok(bytes, headers: {
    'Content-Type': mime,
    'Access-Control-Allow-Origin': '*',
    'Cache-Control': 'public, max-age=86400'
  });
}

String? _readArg(List<String> args, String name) {
  final idx = args.indexOf(name);
  if (idx == -1) return null;
  if (idx + 1 >= args.length) return null;
  return args[idx + 1];
}
