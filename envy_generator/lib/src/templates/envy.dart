import 'package:envy_generator/src/templates/variable.dart';

class EnvyTemplate {
  final List<VariableTemplate> variables;

  const EnvyTemplate(this.variables);

  @override
  String toString() {
    return '''
/// @nodoc
class _Envy {
  $_vars
}
''';
  }

  String get _vars => variables.join('\n\n');
}
