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
    // Lógica aprimorada para garantir imagem sempre que possível
    String finalImageUrl = '';
    if (json['imageUrl'] != null && json['imageUrl'].toString().startsWith('http')) {
      finalImageUrl = json['imageUrl'].toString();
    } else if (json['image'] != null && json['image'].toString().isNotEmpty) {
      final imageFile = json['image'].toString();
      // ThronesAPI padrão
      finalImageUrl = 'https://thronesapi.com/assets/images/$imageFile';
    } else {
      // Placeholder medieval personalizado
      final initials = json['fullName'] != null 
          ? _getInitials(json['fullName'].toString())
          : 'GO';
      finalImageUrl = 'https://ui-avatars.com/api/?name=$initials&background=2c3e50&color=ecf0f1&size=150&font-size=0.5&rounded=true&bold=true';
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
