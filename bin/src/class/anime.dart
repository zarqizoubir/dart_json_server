import 'dart:io';
import 'dart:convert';
import 'package:jaguar/jaguar.dart';

import '../Models/animeModels.dart';

class Anime {
  static init(Jaguar app) async {
    print('animes api started');
    getAllAnimes(app);
    getAllAnimesById(app);
    addAnime(app);
    putAnimes(app);
    deleteAnime(app);
  }

  static getAllAnimes(Jaguar app) {
    app.get('/animes', (context) async {
      File anime = File('DataBase/anime.json');

      List animes = jsonDecode(anime.readAsStringSync())["animes"];
      return jsonEncode(animes);
    });
  }

  static getAllAnimesById(Jaguar app) {
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

  static void putAnimes(Jaguar app) {
    app.put(
      '/animes/:id',
      (context) async {
        final int id = context.pathParams.getInt("id")!;
        final newAnime = await context.bodyAsJson();

        File file = File("DataBase/anime.json");

        Map<String, dynamic> Json = jsonDecode(file.readAsStringSync());
        List animes = Json['animes'];

        for (var i = 0; i < animes.length - 1; i++) {
          Map<String, dynamic> anime = animes[i];
          if (anime["id"] == id) {
            AnimeModel anm = AnimeModel.fromJson(anime);
            AnimeModel newAnm = AnimeModel.fromJson(newAnime);

            anm.id = id;
            anm.name = newAnm.name;
            anm.year = newAnm.year;
            anm.episodes = newAnm.episodes;
            animes.removeAt(id - 1);
            animes.insert(id - 1, anm.toJson());
            print('added with Succes');
            break;
          }
        }

        Json.addAll({"animes": animes});

        file.writeAsStringSync(jsonEncode(Json));

        return {"Code": "200"};
      },
    );
  }

  static void deleteAnime(Jaguar app) {
    app.delete("/animes/:id", (context) async {
      final int id = context.pathParams.getInt("id")!;

      File file = File("DataBase/anime.json");

      Map<String, dynamic> Json = jsonDecode(file.readAsStringSync());
      List animes = Json['animes'];

      for (var i = 0; i < animes.length - 1; i++) {
        Map<String, dynamic> anime = animes[i];
        if (anime["id"] == id) {
          animes.removeAt(id - 1);
          print("removed with succes");
          break;
        }
      }

      Json.addAll({"animes": animes});

      file.writeAsStringSync(jsonEncode(Json));

      return {"Code": "200"};
    });
  }
}
