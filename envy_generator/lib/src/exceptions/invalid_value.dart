class InvalidValueException implements Exception {
  final String type;

  final String? value;

  final String variable;

  const InvalidValueException({
    required this.type,
    required this.value,
    required this.variable,
  });

  @override
  String toString() {
    return 'InvalidValueException: type $type does not support value $value';
  }
}
