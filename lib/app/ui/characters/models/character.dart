class Character {
  final int id;
  final String name;
  final String birthday;
  final List<String> occupation;
  final String img;
  final String status;
  final String nickname;
  final List<int> appearance;
  final String portrayed;
  final String category;

  Character(
      {required this.id,
      required this.name,
      required this.birthday,
      required this.occupation,
      required this.img,
      required this.status,
      required this.nickname,
      required this.appearance,
      required this.portrayed,
      required this.category});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        id: json['char_id'],
        name: json['name'],
        birthday: json['birthday'],
        occupation: json['occupation'].cast<String>(),
        img: json['img'],
        status: json['status'],
        nickname: json['nickname'],
        appearance: json['appearance'].cast<int>(),
        portrayed: json['portrayed'],
        category: json['category']);
  }
}
