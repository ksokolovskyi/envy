import 'package:build/build.dart';
import 'package:dotenv/dotenv.dart';
import 'package:envy_generator/src/env.dart';
import 'package:envy_generator/src/envy_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Builds generators for `build_runner` to run
Builder envy(BuilderOptions options) {
  return PartBuilder(
    [
      EnvyGenerator(
        Env(
          DotEnv(includePlatformEnvironment: true),
        ),
      )
    ],
    '.e.dart',
    header: '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
    ''',
    options: options,
  );
}
