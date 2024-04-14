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
  List<String>? interests;
  List<College>? colleges;
  String? photo;
  String? bday;
  String? bio;

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
    required this.bio,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    String name = json['name'] ?? "";
    String email = json['email'] ?? "";
    int grad = json['grad'] ?? 0;
    String state = json['state'] ?? "";
    String school = json['school'] ?? "";
    String bday = json['bday'] ?? "";
    String bio = json['bio'] ?? "";

    List<String> interests = (json['interests'] as List?)?.map((item) => item as String).toList() ?? <String>[];
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
      bio: bio,
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
