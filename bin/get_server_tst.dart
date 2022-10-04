import 'package:jaguar/jaguar.dart';
import 'dart:io';

import 'src/anime.dart';

void main(List<String> args) {
  final app = Jaguar(port: 8000);
  Anime.init(app);

  app.serve();
}
