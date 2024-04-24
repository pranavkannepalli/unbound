class AuthUser {
  String uid;
  AuthUser({required this.uid});
}

class UserData {
  String name;
  String email;
  int grad;
  String state;
  String school;
  List<String> interests;
  String photo;
  String bday;
  String bio;
  List<String> posts;
  List<TestScore> tests;
  List<Course> courses;
  List<Club> clubs;
  List<Art> arts;
  List<Sport> sports;
  List<Work> works;
  List<Project> projects;
  List<String> following;

  UserData(
      {required this.name,
      required this.email,
      required this.grad,
      required this.state,
      required this.school,
      required this.interests,
      required this.photo,
      required this.bday,
      required this.bio,
      required this.posts,
      required this.tests,
      required this.courses,
      required this.clubs,
      required this.arts,
      required this.sports,
      required this.works,
      required this.projects,
      required this.following});

  factory UserData.fromJson(Map<String, dynamic> json) {
    String name = json['name'] ?? "";
    String email = json['email'] ?? "";
    int grad = json['grad'] ?? 0;
    String state = json['state'] ?? "";
    String school = json['school'] ?? "";
    String bday = json['bday'] ?? "";
    String bio = json['bio'] ?? "";
    List<String> interests = (json['interests'] as List?)?.map((item) => item as String).toList() ?? <String>[];
    List<String> posts = (json['posts'] as List?)?.map((item) => item as String).toList() ?? <String>[];
    //List<String> colleges = (json['colleges'] as List?)?.map((item) => item as String).toList() ?? <String>[];
    List<TestScore> tests = (json['tests'] as List?)?.map((item) => TestScore.fromJson(item)).toList() ?? <TestScore>[];
    List<Course> courses = (json['coursework'] as List?)?.map((item) => Course.fromJson(item)).toList() ?? <Course>[];
    List<Club> clubs = (json['clubs'] as List?)?.map((item) => Club.fromJson(item)).toList() ?? [];
    List<Art> arts = (json['arts'] as List?)?.map((item) => Art.fromJson(item)).toList() ?? [];
    List<Sport> sports = (json['sports'] as List?)?.map((item) => Sport.fromJson(item)).toList() ?? [];
    List<Work> works = (json['work'] as List?)?.map((item) => Work.fromJson(item)).toList() ?? [];
    List<Project> projects = (json['projects'] as List?)?.map((item) => Project.fromJson(item)).toList() ?? [];
    List<String> following = (json["following"] as List?)?.map((e) => e as String).toList() ?? [];
    String photo = json['photo'] ?? "";

    return UserData(
        name: name,
        email: email,
        grad: grad,
        state: state,
        school: school,
        interests: interests,
        photo: photo,
        bday: bday,
        bio: bio,
        posts: posts,
        tests: tests,
        courses: courses,
        clubs: clubs,
        arts: arts,
        sports: sports,
        works: works,
        projects: projects,
        following: following);
  }

  @override
  String toString() => "$name $email";

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "grad": grad,
      "school": school,
      "state": state,
      "interests": interests,
      "following": following,
      "photo": photo,
      "bday": bday,
      "bio": bio,
      "posts": posts,
      "tests": tests.map((e) => e.toJson()).toList(),
      "courses": courses.map((e) => e.toJson()).toList(),
      "clubs": clubs.map((e) => e.toJson()).toList(),
      "arts": arts.map((e) => e.toJson()).toList(),
      "sports": sports.map((e) => e.toJson()).toList(),
      "work": works.map((e) => e.toJson()).toList(),
      "projects": projects.map((e) => e.toJson()).toList(),
    };
  }
}

class TestScore {
  String name;
  String score;
  Map<String, dynamic> sectionScores;

  TestScore({required this.name, required this.score, required this.sectionScores});

  factory TestScore.fromJson(json) {
    return TestScore(
      name: json["name"] ?? "",
      score: json["score"] ?? "",
      sectionScores: json["sectionScores"] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "score": score,
      "sectionScores": sectionScores,
    };
  }
}

class Course {
  String name;
  String years;
  String score;
  String description;

  Course({required this.name, required this.score, required this.years, required this.description});

  factory Course.fromJson(json) {
    return Course(
      name: json["name"] ?? "",
      score: json["score"] ?? "",
      years: json["years"] ?? "",
      description: json["description"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "score": score,
      "years": years,
      "description": description,
    };
  }
}

class Work {
  String name;
  String photo;
  String years;
  String description;

  Work({required this.name, required this.years, required this.photo, required this.description});

  factory Work.fromJson(json) {
    return Work(
      name: json["name"] ?? "",
      years: json["years"] ?? "",
      photo: json["photo"] ?? "",
      description: json["description"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "years": years,
      "photo": photo,
      "description": description,
    };
  }
}

class Club {
  String photo;
  String name;
  String years;
  List<Role> roles;
  List<Accomplishment> accomplishments;

  Club({required this.photo, required this.name, required this.years, required this.roles, required this.accomplishments});

  factory Club.fromJson(json) {
    var photo = json["photo"] ?? "";
    var name = json["name"] ?? "";
    var years = json["years"] ?? "";
    List<Role> roles = (json['roles'] as List?)?.map((item) => Role.fromJson(item)).toList() ?? <Role>[];
    List<Accomplishment> accomplishments =
        (json['accomplishments'] as List?)?.map((item) => Accomplishment.fromJson(item)).toList() ?? <Accomplishment>[];

    return Club(photo: photo, name: name, years: years, roles: roles, accomplishments: accomplishments);
  }

  Map<String, dynamic> toJson() {
    return {
      "photo": photo,
      "name": name,
      "years": years,
      "roles": roles.map((e) => e.toJson()).toList(),
      "accomplishments": accomplishments.map((e) => e.toJson()).toList(),
    };
  }
}

class Art {
  List<String> photos;
  String name;
  String years;
  List<Accomplishment> accomplishments;

  Art({required this.photos, required this.name, required this.years, required this.accomplishments});

  factory Art.fromJson(json) {
    var photos = (json['photos'] as List?)?.map((item) => item as String).toList() ?? [];
    var name = json["name"] ?? "";
    var years = json["years"] ?? "";
    List<Accomplishment> accomplishments =
        (json['accomplishments'] as List?)?.map((item) => Accomplishment.fromJson(item)).toList() ?? <Accomplishment>[];

    return Art(photos: photos, name: name, years: years, accomplishments: accomplishments);
  }

  Map<String, dynamic> toJson() {
    return {
      "photos": photos,
      "name": name,
      "years": years,
      "accomplishments": accomplishments.map((e) => e.toJson()).toList(),
    };
  }
}

class Project {
  List<String> photos;
  String name;
  String years;
  List<String> skills;
  String description;

  Project({required this.photos, required this.name, required this.years, required this.skills, required this.description});

  factory Project.fromJson(json) {
    var photos = (json['photos'] as List?)?.map((item) => item as String).toList() ?? [];
    var name = json["name"] ?? "";
    var years = json["years"] ?? "";
    var description = json["description"] ?? "";
    var skills = (json['skills'] as List?)?.map((item) => item as String).toList() ?? [];

    return Project(photos: photos, name: name, years: years, skills: skills, description: description);
  }

  Map<String, dynamic> toJson() {
    return {
      "photos": photos,
      "name": name,
      "years": years,
      "description": description,
      "skills": skills,
    };
  }
}

class Sport {
  List<String> photos;
  String name;
  String years;
  List<Accomplishment> accomplishments;
  Map<String, dynamic> stats;
  String position;

  Sport(
      {required this.photos,
      required this.name,
      required this.years,
      required this.position,
      required this.accomplishments,
      required this.stats});

  factory Sport.fromJson(json) {
    var photos = (json['photos'] as List?)?.map((item) => item as String).toList() ?? [];
    var name = json["name"] ?? "";
    var years = json["years"] ?? "";
    List<Accomplishment> accomplishments =
        (json['accomplishments'] as List?)?.map((item) => Accomplishment.fromJson(item)).toList() ?? <Accomplishment>[];
    var stats = json["stats"] as Map<String, dynamic>;
    var position = json["position"] ?? "";

    return Sport(photos: photos, name: name, years: years, position: position, accomplishments: accomplishments, stats: stats);
  }

  Map<String, dynamic> toJson() {
    return {
      "photos": photos,
      "name": name,
      "years": years,
      "accomplishments": accomplishments.map((e) => e.toJson()).toList(),
      "position": "position",
    };
  }
}

class Role {
  String name;
  String years;
  String description;

  Role({required this.name, required this.description, required this.years});

  factory Role.fromJson(json) {
    var name = json["name"] ?? "";
    var years = json["years"] ?? "";
    var description = json["description"] ?? "";

    return Role(
      name: name,
      years: years,
      description: description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "years": years,
      "description": description,
    };
  }
}

class Accomplishment {
  String place;
  String name;
  String location;
  String year;
  String link;

  Accomplishment({required this.place, required this.name, required this.location, required this.year, required this.link});

  factory Accomplishment.fromJson(json) {
    var name = json["name"] ?? "";
    var place = json["place"] ?? "";
    var location = json["location"] ?? "";
    var year = json["year"] ?? "";
    var link = json["link"] ?? "";

    return Accomplishment(place: place, name: name, location: location, year: year, link: link);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "place": place, "location": location, "year": year, "link": link};
  }
}
