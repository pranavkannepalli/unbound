import 'package:cloud_firestore/cloud_firestore.dart';

class College {
  late String bgImg;
  late String photo;
  late String uid;
  late String name;
  late String type;
  late String location;
  late String bio;
  late List<Stat> quickStats;
  late ApplicationInfo applicationInfo;
  late List<Highlight> highlights;
  late List<Major> majors;
  late List<Stat> livingStats;
  late Diversity diversity;
  late List<Activity> activities;
  late List<Organization> organizations;
  late List<Review> reviews;

  College({
    required this.bgImg,
    required this.photo,
    required this.uid,
    required this.name,
    required this.type,
    required this.location,
    required this.bio,
    required this.quickStats,
    required this.applicationInfo,
    required this.highlights,
    required this.majors,
    required this.livingStats,
    required this.diversity,
    required this.activities,
    required this.organizations,
    required this.reviews,
  });

  College.fromJSON(Map<String, dynamic> data) {
    bgImg = (data["bgImg"] ?? "") as String;
    photo = (data["photo"] ?? "") as String;
    uid = (data["id"] ?? "") as String;
    name = (data["name"] ?? "") as String;
    type = (data["type"] ?? "") as String;
    location = (data["location"] ?? "") as String;
    bio = (data["bio"] ?? "") as String;
    quickStats = (data["quickStats"] as List?)?.map((item) => Stat.fromJSON(item)).toList() ?? <Stat>[];
    applicationInfo = ApplicationInfo.fromJSON(data["applicationInfo"] ?? <String, dynamic>{});
    highlights = (data["highlights"] as List?)?.map((item) => Highlight.fromJSON(item)).toList() ?? <Highlight>[];
    majors = (data["majors"] as List?)?.map((data) => Major.fromJSON(data)).toList() ?? <Major>[];
    livingStats = (data["livingStats"] as List?)?.map((data) => Stat.fromJSON(data)).toList() ?? <Stat>[];
    diversity = Diversity.fromJSON(data["diversity"] ?? <String, dynamic>{});
    activities = (data["activities"] as List?)?.map((data) => Activity.fromJSON(data)).toList() ?? <Activity>[];
    organizations = (data["organizations"] as List?)?.map((data) => Organization.fromJSON(data)).toList() ?? <Organization>[];
    print(organizations);
    reviews = (data["reviews"] as List?)?.map((data) => Review.fromJSON(data)).toList() ?? <Review>[];
  }


}

class Review {
  late String photo;
  late String classOf;
  late int stars;
  late String text;
  late String name;

  Review({
    required this.name,
    required this.classOf,
    required this.stars,
    required this.text,
    required this.photo
  });

  Review.fromJSON(Map<String, dynamic> data) {
    photo = (data["photo"] ?? "") as String;
    classOf = (data["classOf"] ?? "") as String;
    text = (data["text"] ?? "") as String;
    name = (data["name"] ?? "") as String;
    stars = (data["stars"] ?? 0) as int;
  }

}


class Organization {
  late String photo;
  late String name;
  late int members;
  late String link;

  Organization.fromJSON(Map<String, dynamic> data) {
    photo = (data["photo"] ?? "") as String;
    name = (data["name"] ?? "") as String;
    members = (data["members"] ?? 0) as int;
    link = (data["link"] ?? "") as String;
  }

  Organization({
    required this.photo,
    required this.name,
    required this.members,
    required this.link
  });
}


class Activity {
  late String photo;
  late String name;
  late String distance;
  late String description;
  late int stars;
  late int number;

  Activity({ 
    required this.photo,
    required this.name,
    required this.distance,
    required this.description,
    required this.stars,
    required this.number
  });

  Activity.fromJSON(Map<String, dynamic> data) {
    photo = (data["photo"] ?? "") as String;
    name = (data["name"] ?? "") as String;
    distance = (data["distance"] ?? "") as String;
    description = (data["description"] ?? "") as String;
    stars = (data["stars"] ?? 0) as int;
    number = (data["number"] ?? 0) as int;
  }
}


class Diversity {
  late double white;
  late double black;
  late double hispanic;
  late double asian;
  late double native;
  late double other;

  Diversity({
    required this.white,
    required this.black,
    required this.hispanic,
    required this.asian,
    required this.native,
    required this.other
  });

  Diversity.fromJSON(Map<String, dynamic> data) {
    white = (data["white"] ?? 0) as double;
    black = (data["black"] ?? 0) as double;
    hispanic = (data["hispanic"] ?? 0) as double;
    asian = (data["asian"] ?? 0) as double;
    native = (data["native"] ?? 0) as double;
    other = (data["other"] ?? 0) as double;
  }
}


class Major {
  late String name;
  late int students;
  late String stat;

  Major({ required this.name, required this.students, required this.stat });

  Major.fromJSON(Map<String, dynamic> data) {
    name = (data["name"] ?? "") as String;
    students = (data["students"] ?? 0) as int;
    stat = (data["stat"] ?? "") as String;
  }
}


class Stat {
  late String name;
  late String statistic;
  late String caption;

  Stat({ required this.name, required this.statistic, required this.caption });

  Stat.fromJSON(Map<String, dynamic> data) {
    name = (data["name"] ?? "") as String;
    statistic = (data["statistic"] ?? "") as String;
    caption = (data["caption"] ?? "") as String;
  }
}

class ApplicationInfo {
  late Timestamp? earlyDecision;
  late Timestamp? regularDecision;
  late Timestamp? transfer;
  late String link;

  ApplicationInfo({
    required this.earlyDecision,
    required this.regularDecision,
    required this.transfer,
    required this.link
  });

  ApplicationInfo.fromJSON(Map<String, dynamic> data) {
    earlyDecision = (data["earlyDecision"]) as Timestamp?;
    regularDecision = (data["regularDecision"]) as Timestamp?;
    transfer = (data["transfer"]) as Timestamp?;
    link = (data["link"] ?? "") as String;
  }

}

class Highlight {
  late String number;
  late String name;
  late String source;
  late Timestamp date;
  late String link;

  Highlight({
    required this.number,
    required this.name,
    required this.source,
    required this.date,
    required this.link
  });

  Highlight.fromJSON(Map<String, dynamic> data) {
    number = (data["number"] ?? "") as String;
    name = (data["name"] ?? "") as String;
    source = (data["source"] ?? "") as String;
    date = data["date"] as Timestamp;
    link = (data["link"] ?? "") as String;
  }
}
