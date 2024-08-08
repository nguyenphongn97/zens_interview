enum VoteJoke {funny, notFunny}

class Joke{

  Joke({required this.id, this.joke, this.vote});
  int id;
  String? joke;
  bool? vote;
}