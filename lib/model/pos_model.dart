class Pos {
  final int? id;
  final String title;
  final String description;

  Pos({required this.id, required this.title, required this.description});

  factory Pos.fromJson(Map<String, dynamic> json) => Pos(
        id: json['id'],
        title: json['title'],
        description: json['description'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
