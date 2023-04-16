class Boulder {
  late String id;
  late String name;
  late List<dynamic> holds;
  late num stars;
  late num ratingsCount;
  late num sendCount;
  late String description;
  late String user;
  late num grade;
  late String location;
  late bool private;
  late int updatedAt;
  late int createdAt;

  Boulder({
    required this.id,
    required this.name,
    required this.holds,
    required this.stars,
    required this.ratingsCount,
    required this.sendCount,
    required this.description,
    required this.user,
    required this.grade,
    required this.location,
    required this.private,
    required this.updatedAt,
    required this.createdAt,
  });

  Boulder.create(this.name, this.holds, this.description, this.user, this.location, this.private)
      : id = 'id',
        stars = 0,
        ratingsCount = 0,
        sendCount = 0,
        grade = -1,
        createdAt = DateTime.now().millisecondsSinceEpoch,
        updatedAt = DateTime.now().millisecondsSinceEpoch;

  Boulder update(name, holds, description, private) {
    this.name = name;
    this.holds = holds;
    this.description = description;
    this.private = private;
    updatedAt = DateTime.now().millisecondsSinceEpoch;
    return this;
  }

  Boulder.fromSnapshot(document)
      : id = document["id"],
        name = document["name"],
        holds = document["holds"],
        stars = document["stars"],
        ratingsCount = document["ratingsCount"],
        sendCount = document["sendCount"],
        description = document["description"],
        user = document["user"],
        grade = document["grade"],
        location = document["location"],
        private = document["private"],
        createdAt = document["createdAt"],
        updatedAt = document["updatedAt"];

  Map<String, dynamic> toJson({includeId = false}) {
    var map = {};

    if (includeId) {
      map["id"] = id;
    }

    return {
      ...map,
      ...{
        "name": name,
        "holds": holds,
        "stars": stars,
        "ratingsCount": ratingsCount,
        "sendCount": sendCount,
        "description": description,
        "user": user,
        "grade": grade,
        "location": location,
        "private": private,
        "updatedAt": updatedAt,
        "createdAt": createdAt
      }
    };
  }
}
