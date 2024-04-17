class FeedData {
  late Feed collegeFeed;
  late Feed studentFeed;
  late Feed jobFeed;

  FeedData({required this.collegeFeed, required this.studentFeed, required this.jobFeed});
}

class Feed {
  late List<Post> posts;
  late List<Account> recommended;

  Feed({required this.posts, required this.recommended});

  static List<Post> postsFromJSON(List<dynamic> posts) {
    return posts.map((e) => Post.fromJSON(e)) as List<Post>;
  }

  static List<Account> recommendedFromJSON(List<dynamic> accounts) {
    return accounts.map((e) => Account.fromJSON(e)) as List<Account>;
  }

  recommendedJSON() {
    List<dynamic> data = recommended.map((e) => e.toJSON()) as List<dynamic>;
    return data;
  }

  postsJSON() {
    List<dynamic> data = posts.map((e) => e.toJSON()) as List<dynamic>;
    return data;
  }

  @override
  String toString() => "Posts: $posts";
}

class Account {
  late String name;
  late String uid;
  late String pfp;

  Account({required this.name, required this.uid, required this.pfp});

  Account.fromJSON(Map<String, dynamic> data) {
    name = (data["name"] ?? "") as String;
    uid = (data["uid"] ?? "") as String;
    pfp = (data["photo"] ?? "") as String;
  }

  toJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["uid"] = uid;
    data["pfp"] = pfp;
    return data;
  }

  @override
  String toString() => "$name $uid";
}

class Post {
  late String author;
  late String uid;
  late String photo;
  late String pfp;
  late String text;
  late String time;
  late int likes;
  late List<Comment> comments;
  late bool isJob;

  Post(
      {required this.author,
      required this.pfp,
      required this.text,
      required this.likes,
      required this.comments,
      required this.uid,
      required this.photo,
      required this.time,
      this.isJob = false});

  Post.fromJSON(Map<String, dynamic> data) {
    author = (data["author"] ?? "") as String;
    uid = (data["uid"] ?? "") as String;
    pfp = (data["pfp"] ?? "") as String;
    photo = (data["photo"] ?? "") as String;
    text = (data["text"] ?? "") as String;
    time = (data["time"] ?? "") as String;
    likes = (data["likes"] ?? 0) as int;
    Iterable<Comment> c = (data["comments"] as List<dynamic>).map((e) => Comment.fromJSON(e));
    comments = c.toList();
    isJob = (data.containsKey("isJob") ? data["isJob"] ?? false : false) as bool;
  }

  toJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["author"] = author;
    data["pfp"] = pfp;
    data["text"] = text;
    data["likes"] = likes;
    data["comments"] = comments.map((e) => e.toJSON());
    data["isJob"] = isJob;
    return data;
  }

  @override
  String toString() => "$author $likes $text";
}

class Comment {
  late String author;
  late String text;
  late String time;
  late int likes;
  late String pfp;
  late String uid;

  Comment(
      {required this.author, required this.text, required this.time, required this.likes, required this.pfp, required this.uid});

  Comment.fromJSON(Map<String, dynamic> data) {
    author = (data["author"] ?? "") as String;
    text = (data["text"] ?? "") as String;
    time = (data["time"] ?? "") as String;
    likes = (data["likes"] ?? 0) as int;
    pfp = (data["pfp"] ?? "") as String;
    uid = (data["uid"] ?? "") as String;
  }

  toJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["author"] = author;
    data["text"] = text;
    data["time"] = time;
    data["likes"] = likes;
    data["pfp"] = pfp;
    return data;
  }
}
