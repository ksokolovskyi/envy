import 'package:envy_generator/src/variable_config.dart';

class VariableTemplate {
  final VariableConfig config;

  const VariableTemplate(this.config);

  @override
  String toString() {
    return 'static const ${config.type} ${config.name} = ${config.valueToString};';
  }
}
