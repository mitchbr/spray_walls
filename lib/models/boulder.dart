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

  Boulder(
      {required this.id,
      required this.name,
      required this.holds,
      required this.stars,
      required this.ratingsCount,
      required this.sendCount,
      required this.description,
      required this.user,
      required this.grade,
      required this.location,
      required this.private});

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
        private = document["private"];
}