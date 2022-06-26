import 'dart:async';

import 'package:dotenv/dotenv.dart';
import 'package:envy_annotation/envy_annotation.dart';
import 'package:envy_generator/src/env.dart';
import 'package:envy_generator/src/envy_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
    'test',
    'source_gen_src.dart',
  );

  initializeBuildLogTracking();

  testAnnotatedElements<Envy>(
    reader,
    EnvyGenerator(
      Env(
        DotEnv(includePlatformEnvironment: true),
      ),
    ),
  );
}
