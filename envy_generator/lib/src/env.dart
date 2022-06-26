import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:envy_generator/src/exceptions/file_not_found.dart';

class Env {
  final DotEnv _env;

  String? operator [](String key) => _env[key];

  Env(this._env);

  void load({String path = '.env'}) {
    if (!File(path).existsSync()) {
      throw FileNotFoundException(path);
    }

    _env.load([path]);
  }
}
