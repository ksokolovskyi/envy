import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:envy_generator/src/exceptions/exceptions.dart';

enum VariableType {
  int,
  nullableInt,
  double,
  nullableDouble,
  bool,
  nullableBool,
  string,
  nullableString;

  @override
  String toString() {
    switch (this) {
      case VariableType.int:
        return 'int';
      case VariableType.nullableInt:
        return 'int?';

      case VariableType.double:
        return 'double';
      case VariableType.nullableDouble:
        return 'double?';

      case VariableType.bool:
        return 'bool';
      case VariableType.nullableBool:
        return 'bool?';

      case VariableType.string:
        return 'String';
      case VariableType.nullableString:
        return 'String?';
    }
  }
}

class VariableConfig {
  final VariableType type;

  final String name;

  final Object? value;

  VariableConfig._({
    required this.type,
    required this.name,
    required this.value,
  });

  factory VariableConfig.fromElementData({
    required DartType dartType,
    required String name,
    required String? value,
  }) {
    final typeString = dartType.getDisplayString(withNullability: true);

    final VariableType type;

    switch (typeString) {
      case 'int':
        type = VariableType.int;
        break;
      case 'int?':
        type = VariableType.nullableInt;
        break;

      case 'double':
        type = VariableType.double;
        break;
      case 'double?':
        type = VariableType.nullableDouble;
        break;

      case 'bool':
        type = VariableType.bool;
        break;
      case 'bool?':
        type = VariableType.nullableBool;
        break;

      case 'String':
        type = VariableType.string;
        break;
      case 'String?':
        type = VariableType.nullableString;
        break;

      default:
        throw InvalidTypeException(type: typeString, variable: name);
    }

    final isNullable = dartType.nullabilitySuffix == NullabilitySuffix.question;

    if (value == null && !isNullable) {
      throw InvalidValueException(
        type: typeString,
        value: value,
        variable: name,
      );
    }

    if (value == null) {
      return VariableConfig._(
        type: type,
        name: name,
        value: value,
      );
    }

    try {
      switch (type) {
        case VariableType.int:
        case VariableType.nullableInt:
          final v = int.parse(value);

          return VariableConfig._(
            type: type,
            name: name,
            value: v,
          );

        case VariableType.double:
        case VariableType.nullableDouble:
          final v = double.parse(value);

          return VariableConfig._(
            type: type,
            name: name,
            value: v,
          );

        case VariableType.bool:
        case VariableType.nullableBool:
          final v = () {
            switch (value.toLowerCase()) {
              case 'true':
                return true;

              case 'false':
                return false;

              default:
                throw const FormatException();
            }
          }();

          return VariableConfig._(
            type: type,
            name: name,
            value: v,
          );

        case VariableType.string:
        case VariableType.nullableString:
          return VariableConfig._(
            type: type,
            name: name,
            value: value,
          );
      }
    } on FormatException {
      throw InvalidValueException(
        type: typeString,
        value: value,
        variable: name,
      );
    } catch (e) {
      rethrow;
    }
  }

  String get valueToString {
    if (value == null) {
      return null.toString();
    }

    switch (type) {
      case VariableType.int:
      case VariableType.nullableInt:
      case VariableType.double:
      case VariableType.nullableDouble:
      case VariableType.bool:
      case VariableType.nullableBool:
        return '$value';

      case VariableType.string:
      case VariableType.nullableString:
        return "'$value'";
    }
  }
}
