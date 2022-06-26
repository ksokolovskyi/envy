import 'package:meta/meta_meta.dart';

const envy = Envy();

@Target(const {TargetKind.classType})
class Envy {
  final String path;

  const Envy({this.path = '.env'});
}

const variable = Variable();

@Target(const {TargetKind.getter, TargetKind.field})
class Variable {
  const Variable();
}
