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

  factory User.fromJson(Map<String, dynamic> json) {
    String name = json['name'] as String;
    String email = json['email'] as String;
    int gradYear = json['grad'] as int;
    String state = json['state'] as String;
    String school = json['school'] as String;

    List<Interest> interests = <Interest>[];
    if (json['interests'] != null) {
      json['interests'].forEach((v) {
        interests!.add(Interest(name: v));
      });
    }

    List<College> colleges = <College>[];
    if (json['colleges'] != null) {
      json['colleges'].forEach((v) {
        colleges!.add(College.fromJson(v));
      });
    }

    String photo = json['photo'] as String;

    return User(
        name: name,
        email: email,
        gradYear: gradYear,
        state: state,
        school: school,
        interests: interests,
        colleges: colleges,
        photo: photo);
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

  factory College.fromJson(Map<String, dynamic> json) {
    String name = json['name'];
    String photo = json['photo'];

    return College(name: name, photo: photo);
  }
}
