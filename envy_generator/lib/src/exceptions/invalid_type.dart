class InvalidTypeException implements Exception {
  final String type;

  final String variable;

  const InvalidTypeException({
    required this.type,
    required this.variable,
  });

  @override
  String toString() {
    return 'InvalidTypeException: type $type is not supported';
  }
}
