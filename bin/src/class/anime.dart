import 'dart:io';
import 'dart:convert';
import 'package:jaguar/jaguar.dart';

class Anime {
  static init(Jaguar app) async {
    getAllAnimes(app);
    getAllAnimesById(app);
    addAnime(app);
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

  static getAllAnimesById(Jaguar app) {
    print('animes api started');
    app.get('/animes/:id', (context) async {
      final int id = context.pathParams.getInt("id")!;

      File anime = File('DataBase/anime.json');

      List animes = jsonDecode(anime.readAsStringSync())["animes"];

      Map<String, dynamic> allAnimes = {};
      allAnimes.addAll({"$id": animes[id - 1]});
      return jsonEncode(allAnimes);
    });
  }

  static void addAnime(Jaguar app) {
    app.postJson('/animes', (context) async {
      final data = await context.bodyAsJson();
      File file = File("DataBase/anime.json");
      print(file.existsSync());
      print(data);

      Map<String, dynamic> anime = jsonDecode(file.readAsStringSync());
      List animes = anime['animes'];

      animes.add(data);
      print(animes);

      anime.addAll({"animes": animes});

      file.writeAsStringSync(jsonEncode(anime));
      return {"CODE": "200"};
    });
  }
}
