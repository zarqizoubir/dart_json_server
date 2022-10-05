class Anime {
  String? name;
  String? year;
  String? episodes;

  Anime({
    this.name,
    this.year,
    this.episodes,
  });

  Anime.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    year = json['year'];
    episodes = json['episodes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['year'] = this.year;
    data['episodes'] = this.episodes;
    return data;
  }
}
