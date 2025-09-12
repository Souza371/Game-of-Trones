# Game of Thrones - Catálogo de Personagens

![Game of Thrones](https://img.shields.io/badge/Game%20of%20Thrones-Westeros-red)
![Flutter](https://img.shields.io/badge/Flutter-3.19-blue)
![Status](https://img.shields.io/badge/Status-Desenvolvimento-orange)

Um aplicativo Flutter que apresenta personagens do universo de Game of Thrones, funcionando como uma enciclopédia digital interativa com design inspirado no mundo de Westeros.

## 📱 Funcionalidades

- **Catálogo de Personagens**: Visualize todos os personagens de Game of Thrones
- **Busca Inteligente**: Encontre personagens por nome, casa ou título em tempo real
- **Detalhes Completos**: Informações detalhadas sobre cada personagem com imagens
- **Design Temático**: Interface inspirada no universo de Westeros
- **Multiplataforma**: Funciona em Android, iOS e Web
- **Filtros por Casas**: Visualize personagens por casa nobre (Stark, Lannister, Targaryen, etc.)

## 🛠️ Tecnologias Utilizadas

- **Flutter 3.19.0** - Framework principal
- **Dart 3.3.0** - Linguagem de programação
- **ThronesAPI** - API para dados dos personagens
- **Cached Network Image** - Cache de imagens
- **Provider** - Gerenciamento de estado

## 📦 Instalação

### Pré-requisitos


### Clonando o Repositório

```bash
git clone https://github.com/Souza371/Game-of-Trones.git
cd Game-of-Trones


### Image Proxy (Web CORS workaround)

Para evitar erros de CORS/Encoding ao carregar imagens externas no Flutter Web, foi adicionado um microserviço em `image_proxy/`.

Passos:
1. Abrir terminal na pasta `image_proxy`.
2. Executar:
	```powershell
	dart pub get
	dart run bin/main.dart --port 8081
	```
3. O app Web reescreve URLs de imagem para `http://localhost:8081/image?url=<original_url>` quando `kIsWeb`.

Se precisar mudar porta/host (deploy), ajustar constante `_proxyBase` em `lib/screens/characters_screen.dart`.

Produção:
- Hospedar esse proxy atrás de HTTPS.
- Adicionar cache CDN se quiser melhor performance.

Segurança:
- Atualmente aceita qualquer URL. Para endurecer, permitir somente host `thronesapi.com` (validar antes de fazer request).

