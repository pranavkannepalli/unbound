class Company {
  String bgImg;
  String photo;
  String name;
  String founded;
  String location;
  String description;
  List<Internship> internships;
  List<String> posts;

  Company(
      {required this.bgImg,
      required this.photo,
      required this.name,
      required this.founded,
      required this.location,
      required this.description,
      required this.internships,
      required this.posts});

  factory Company.fromJSON(Map<String, dynamic> json) {
    String name = json["name"] ?? "";
    String bgImg = json["bgImg"] ?? "";
    String photo = json["photo"] ?? "";
    String founded = json["founded"] ?? "";
    String location = json["location"] ?? "";
    String description = json["description"] ?? "";
    List<Internship> internships = (json['internships'] as List?)?.map((item) => Internship.fromJSON(item)).toList() ?? <Internship>[];
    List<String> posts = (json['posts'] as List?)?.map((item) => item as String).toList() ?? <String>[];

    return Company(
        bgImg: bgImg,
        photo: photo,
        name: name,
        founded: founded,
        location: location,
        description: description,
        internships: internships,
        posts: posts);
  }
}

class Internship {
  late List<Benefit> benefits;
  late String description;
  late String level;
  late String link;
  late String location;
  late String name;
  late String pay;
  late String team;
  late String time;

  Internship(
      {required this.benefits,
      required this.description,
      required this.level,
      required this.link,
      required this.location,
      required this.name,
      required this.pay,
      required this.team,
      required this.time});

  Internship.fromJSON(Map<String, dynamic> data) {
    description = (data["description"] ?? []) as String;
    benefits = (data['benefits'] as List?)?.map((item) => Benefit.fromJSON(item)).toList() ?? <Benefit>[];
    level = (data["level"] ?? []) as String;
    link = (data["link"] ?? []) as String;
    location = (data["location"] ?? []) as String;
    name = (data["name"] ?? []) as String;
    pay = (data["pay"] ?? []) as String;
    team = (data["team"] ?? []) as String;
    time = (data["time"] ?? []) as String;
  }
}

class Benefit {
  late String icon;
  late String name;

  Benefit({required this.icon, required this.name});

  Benefit.fromJSON(Map<String, dynamic> data) {
    icon = (data["icon"] ?? "") as String;
    name = (data["name"] ?? "") as String;
  }
}
