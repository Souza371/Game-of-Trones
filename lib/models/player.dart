class Player {
  String name;
  int level;
  Map<String, int> attributes;
  List<String> skills;
  String house;
  
  Player({
    required this.name,
    this.level = 1,
    this.attributes = const {
      'Honra': 0,
      'Inteligência': 0,
      'Força': 0,
      'Ambição': 0,
      'Lealdade': 0,
      'Estratégia': 0
    },
    this.skills = const [],
    this.house = ''
  });
  
  void levelUp() {
    level++;
  }
  
  void addSkill(String skill) {
    if (!skills.contains(skill)) {
      skills.add(skill);
    }
  }
  
  void updateAttribute(String attribute, int points) {
    attributes[attribute] = (attributes[attribute] ?? 0) + points;
  }
}
