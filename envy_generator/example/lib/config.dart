import 'package:envy_annotation/envy_annotation.dart';

part 'config.e.dart';

@envy
class Config {
  @variable
  static String apiBaseUrl = _Envy.apiBaseUrl;

  @variable
  static String get apiUrl => _Envy.apiUrl;

  @variable
  static bool get devMode => _Envy.devMode;

  @variable
  static int get threadsCount => _Envy.threadsCount;

  @variable
  static double get similarityDistanceThreshold =>
      _Envy.similarityDistanceThreshold;

  @variable
  static String? get missingOne => _Envy.missingOne;

  static String get testVar => 'test';
}
