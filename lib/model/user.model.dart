class AuthUser {
  String uid;
  AuthUser({required this.uid});
}

class UserData {
  String? name;
  String? email;
  int? grad;
  String? state;
  String? school;
  List<Interest>? interests;
  List<College>? colleges;
  String? photo;
  String? bday;

  UserData({
    required this.name,
    required this.email,
    required this.grad,
    required this.state,
    required this.school,
    required this.interests,
    required this.colleges,
    required this.photo,
    required this.bday,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    String name = json['name'] ?? "";
    String email = json['email'] ?? "";
    int grad = json['grad'] ?? 0;
    String state = json['state'] ?? "";
    String school = json['school'] ?? "";
    String bday = json['bday'] ?? "";

    List<Interest> interests = <Interest>[];
    try {
      if (json['interests'] != null) {
        json['interests'].forEach((v) {
          interests.add(Interest(name: v));
        });
      }
    } catch (e) {
      print(e);
    }

    List<College> colleges = <College>[];
    try {
      if (json['colleges'] != null) {
        json['colleges'].forEach((v) {
          colleges.add(College.fromJson(v));
        });
      }
    } catch (e) {
      print(e);
    }

    String photo = json['photo'] ?? "";

    return UserData(
      name: name,
      email: email,
      grad: grad,
      state: state,
      school: school,
      interests: interests,
      colleges: colleges,
      photo: photo,
      bday: bday,
    );
  }

  @override
  String toString() => "$name $email";
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
