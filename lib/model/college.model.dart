import 'package:cloud_firestore/cloud_firestore.dart';

class College {
  late String bgImg;
  late String photo;
  late String id;
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
  late List<String> postIds;

  College({
    required this.bgImg,
    required this.photo,
    required this.id,
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
    required this.postIds
  });

  College.fromJSON(Map<String, dynamic> data) {
    bgImg = (data["bgImg"] ?? "") as String;
    photo = (data["photo"] ?? "") as String;
    id = (data["id"] ?? "") as String;
    name = (data["name"] ?? "") as String;
    type = (data["type"] ?? "") as String;
    location = (data["location"] ?? "") as String;
    bio = (data["bio"] ?? "") as String;
    quickStats = ((data["quickStats"] ?? []) as List<Map<String, dynamic>>).map((e) => Stat.fromJSON(e)) as List<Stat>;
    applicationInfo = ApplicationInfo.fromJSON(data["applicationInfo"] ?? <String, dynamic>{});
    highlights = ((data["highlights"] ?? []) as List<Map<String, dynamic>>).map((e) => Highlight.fromJSON(e)) as List<Highlight>;
    majors = ((data["majors"] ?? []) as List<Map<String, dynamic>>).map((e) => Major.fromJSON(e)) as List<Major>;
    livingStats = ((data["livingStats"] ?? []) as List<Map<String, dynamic>>).map((e) => Stat.fromJSON(e)) as List<Stat>;
    diversity = Diversity.fromJSON(data["diversity"] ?? <String, dynamic>{});
    activities = ((data["activities"] ?? []) as List<Map<String, dynamic>>).map((e) => Activity.fromJSON(e)) as List<Activity>;
    organizations = ((data["organizations"] ?? []) as List<Map<String, dynamic>>).map((e) => Organization.fromJSON(e)) as List<Organization>;
    reviews = ((data["reviews"] ?? []) as List<Map<String, dynamic>>).map((e) => Review.fromJSON(e)) as List<Review>;
    postIds = ((data["posts"] ?? []) as List<String>);
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
