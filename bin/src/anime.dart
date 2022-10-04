import 'dart:io';
import 'dart:convert';
import 'package:jaguar/jaguar.dart';

class Anime {
  static init(Jaguar app) async {
    getAllAnimes(app);
  }

  static getAllAnimes(Jaguar app) {
    print('animes api started');
    app.get('/animes', (context) async {
      File anime = File('DataBase/anime.json');

      List animes = jsonDecode(anime.readAsStringSync())["animes"];

      Map<String, dynamic> allAnimes = {};

      for (var i = 0; i <= animes.length - 1; i++) {
        allAnimes.addAll({"$i": animes[i]});
      }

      return jsonEncode(allAnimes);
    });
  }
}
