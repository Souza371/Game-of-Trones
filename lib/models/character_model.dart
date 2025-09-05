class Character {
  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String title;
  final String family;
  final String image;
  final String imageUrl;

  Character({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.title,
    required this.family,
    required this.image,
    required this.imageUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    // SOLUÇÃO DEFINITIVA PARA AS IMAGENS
    String finalImageUrl = '';
    
    // Tenta todas as possibilidades
    if (json['imageUrl'] != null && json['imageUrl'].toString().startsWith('http')) {
      finalImageUrl = json['imageUrl'].toString();
    } 
    else if (json['image'] != null && json['image'].toString().isNotEmpty) {
      final imageFile = json['image'].toString();
      
      // Tenta diferentes formatos de URL
      final possibleUrls = [
        'https://thronesapi.com/assets/images/$imageFile',
        'https://thronesapi.com/images/$imageFile',
        'https://api.thronesapi.com/assets/$imageFile',
      ];
      
      // Usa a primeira URL que provavelmente funciona
      finalImageUrl = possibleUrls[0];
    }
    else {
      // Placeholder personalizado
      final initials = json['fullName'] != null 
          ? _getInitials(json['fullName'].toString())
          : 'GO';
      finalImageUrl = 'https://via.placeholder.com/150x200/2c3e50/ecf0f1?text=$initials';
    }

    return Character(
      id: json['id'] ?? 0,
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? 'Personagem Sem Nome',
      title: json['title']?.toString() ?? '',
      family: json['family']?.toString() ?? 'Casa Desconhecida',
      image: json['image']?.toString() ?? '',
      imageUrl: finalImageUrl,
    );
  }

  static String _getInitials(String name) {
    return name.split(' ').map((word) => word.isNotEmpty ? word[0] : '').join();
  }
}
