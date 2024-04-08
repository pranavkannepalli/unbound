class User {
  String? name;
  String? email;
  int? gradYear;
  String? state;
  String? school;
  List<Interest>? interests;
  List<College>? colleges;
  String? photo;

  User(
      {required this.name,
      required this.email,
      required this.gradYear,
      required this.state,
      required this.school,
      required this.interests,
      required this.colleges,
      required this.photo});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    gradYear = json['grad'];
    state = json['state'];
    school = json['school'];

    interests = <Interest>[];
    if (json['interests'] != null) {
      json['interests'].forEach((v) {
        interests!.add(Interest(name: v));
      });
    }

    colleges = <College>[];
    if (json['colleges'] != null) {
      json['colleges'].forEach((v) {
        colleges!.add(College.fromJson(v));
      });
    }

    photo = json['photo'];
  }
}

class Interest {
  final String name;
  Interest({required this.name});
}

class College {
  String? name;
  String? photo;

  College({required this.name, required this.photo});

  College.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
  }
}
