class Anime {
  int? id;
  String? name;
  String? year;
  String? episodes;

  Anime({this.id, this.name, this.year, this.episodes});

  Anime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    episodes = json['episodes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['year'] = this.year;
    data['episodes'] = this.episodes;
    return data;
  }
}
