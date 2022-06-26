import 'package:envy_annotation/envy_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow(
  '@envy can only be applied on classes. Failing element: wrongTarget',
)
// ignore: invalid_annotation_target
@Envy(path: 'test/.env')
const String wrongTarget = 'wrongTarget';

@ShouldThrow('.env file not found at path nothing/.env')
@Envy(path: 'nothing/.env')
class ConfigEnvNotFound {}

@ShouldGenerate('''
/// @nodoc
class _Envy {}
''')
@Envy(path: 'test/.env')
class ConfigEmpty {
  const ConfigEmpty();
}

@ShouldThrow(
  'Type int does not support value null. Failing variable: notInEnvVar',
)
@Envy(path: 'test/.env')
class ConfigIntVariableNotFoundNotNullable {
  @variable
  static const int notInEnvVar = 0;
}

@ShouldGenerate('''
/// @nodoc
class _Envy {
  static const int? notInEnvVar = null;
}
''')
@Envy(path: 'test/.env')
class ConfigIntVariableNotFoundButNullable {
  @variable
  static const int? notInEnvVar = null;
}

@ShouldThrow(
  'Type int does not support value null. Failing variable: notInEnvGetter',
)
@Envy(path: 'test/.env')
class ConfigIntGetterNotFoundNotNullable {
  @variable
  static int get notInEnvGetter => 0;
}

@ShouldGenerate('''
/// @nodoc
class _Envy {
  static const int? notInEnvGetter = null;
}
''')
@Envy(path: 'test/.env')
class ConfigIntGetterNotFoundButNullable {
  @variable
  static int? get notInEnvGetter => null;
}

@ShouldThrow(
  'Type double does not support value null. Failing variable: notInEnvVar',
)
@Envy(path: 'test/.env')
class ConfigDoubleVariableNotFoundNotNullable {
  @variable
  static const double notInEnvVar = 0.0;
}

@ShouldGenerate('''
/// @nodoc
class _Envy {
  static const double? notInEnvVar = null;
}
''')
@Envy(path: 'test/.env')
class ConfigDoubleVariableNotFoundButNullable {
  @variable
  static const double? notInEnvVar = null;
}

@ShouldThrow(
  'Type bool does not support value null. Failing variable: notInEnvVar',
)
@Envy(path: 'test/.env')
class ConfigBoolVariableNotFoundNotNullable {
  @variable
  static const bool notInEnvVar = true;
}

@ShouldGenerate('''
/// @nodoc
class _Envy {
  static const bool? notInEnvVar = null;
}
''')
@Envy(path: 'test/.env')
class ConfigBoolVariableNotFoundButNullable {
  @variable
  static const bool? notInEnvVar = null;
}

@ShouldThrow(
  'Type String does not support value null. Failing variable: notInEnvVar',
)
@Envy(path: 'test/.env')
class ConfigStringVariableNotFoundNotNullable {
  @variable
  static const String notInEnvVar = 'value';
}

@ShouldGenerate('''
/// @nodoc
class _Envy {
  static const String? notInEnvVar = null;
}
''')
@Envy(path: 'test/.env')
class ConfigStringVariableNotFoundButNullable {
  @variable
  static const String? notInEnvVar = null;
}

@ShouldGenerate('''
/// @nodoc
class _Envy {
  static const String? apiUrl = 'https://my.api/guest/json-rpc';
}
''')
@Envy(path: 'test/.env')
class ConfigStringVariableFoundAndNullable {
  @variable
  static const String? apiUrl = 'apiUrl';
}

@ShouldThrow(
  'Envy supports only limited list of types: int/int?, double/double?, bool/bool?, String/String?. Failing type: ConfigEmpty. Failing variable: config',
)
@Envy(path: 'test/.env')
class ConfigNotSupportedType {
  @variable
  static const ConfigEmpty config = ConfigEmpty();
}

@ShouldThrow(
  'Type int does not support value https://my.api/guest/json-rpc. Failing variable: apiUrl',
)
@Envy(path: 'test/.env')
class ConfigWrongType {
  @variable
  static const int apiUrl = 1;
}

@ShouldGenerate('''
/// @nodoc
class _Envy {
  static const String apiBaseUrl = 'https://my.api';

  static const bool enableLogger = false;

  static const String apiUrl = 'https://my.api/guest/json-rpc';

  static const bool devMode = true;

  static const int threadsCount = 3;

  static const double similarityDistanceThreshold = 0.2;

  static const String? missingOne = null;
}
''')
@Envy(path: 'test/.env')
class Config {
  @variable
  static String apiBaseUrl = 'apiBaseUrl';

  @variable
  static String get apiUrl => 'apiUrl';

  @variable
  static bool get devMode => true;

  @variable
  static bool enableLogger = false;

  @variable
  static int get threadsCount => 3;

  @variable
  static double get similarityDistanceThreshold => 3.33;

  @variable
  static String? get missingOne => null;

  static String get testVar => 'testVar';
}
