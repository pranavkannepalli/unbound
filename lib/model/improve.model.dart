class Exercise {
  String type;
  String title;
  String caption;
  String body;
  String id;

  Exercise({required this.type, required this.title, required this.caption, required this.body, required this.id});

  factory Exercise.fromJSON(Map<String, dynamic> json) {
    String type = json["type"] ?? "";
    String title = json["name"] ?? "";
    String caption = json["caption"] ?? "";
    String body = json["body"] ?? "";
    String id = json["id"] ?? "";
    return Exercise(type: type, title: title, caption: caption, body: body, id: id);
  }
}
