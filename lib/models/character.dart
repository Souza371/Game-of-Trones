class Character {
  final String? name;
  final String? house;
  final String? gender;
  final String? born;
  final String? died;
  final String? imageUrl;

  Character({this.name, this.house, this.gender, this.born, this.died, this.imageUrl});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      house: (json['allegiances'] != null && json['allegiances'].isNotEmpty)
          ? json['allegiances'][0]
          : null,
      gender: json['gender'],
      born: json['born'],
      died: json['died'],
      imageUrl: null, // API não retorna imagem
    );
  }
}
