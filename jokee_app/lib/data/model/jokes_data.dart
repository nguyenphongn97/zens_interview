class JokesData {

  const JokesData({this.jokes});

  factory JokesData.fromJson(Map<String, dynamic> json) => JokesData(
        jokes: json["jokes"] != null
            ? List<JokeData>.from(json["jokes"].map(JokeData.fromJson))
            : null,
      );
  final List<JokeData>? jokes;
}

class JokeData {

  const JokeData({required this.id, this.joke, this.vote});

  factory JokeData.fromJson(Map<String, dynamic> json) =>
      JokeData(id: json["id"], joke: json["joke"], vote: json["vote"]);
      
  final int id;
  final String? joke;
  final int? vote;
}
