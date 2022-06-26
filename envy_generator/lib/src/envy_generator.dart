import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:envy_annotation/envy_annotation.dart';
import 'package:envy_generator/src/env.dart';
import 'package:envy_generator/src/exceptions/exceptions.dart';
import 'package:envy_generator/src/templates/templates.dart';
import 'package:envy_generator/src/variable_config.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

class EnvyGenerator extends GeneratorForAnnotation<Envy> {
  final Env env;

  const EnvyGenerator(this.env);

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    try {
      env.load(path: annotation.read('path').stringValue);
    } on FileNotFoundException catch (e) {
      throw InvalidGenerationSourceError(
        '.env file not found at path ${e.path}',
        element: element,
      );
    }

    final cls = _getClassElement(element);

    final fields = _getAllFields(cls);
    final getters = _getAllGetters(cls);

    try {
      final config = {
        ...fields.map(
          (f) => VariableConfig.fromElementData(
            dartType: f.type,
            name: f.name,
            value: env[f.name.constantCase],
          ),
        ),
        ...getters.map(
          (g) => VariableConfig.fromElementData(
            dartType: g.returnType,
            name: g.name,
            value: env[g.name.constantCase],
          ),
        ),
      };

      final variables = config.map(VariableTemplate.new).toList();

      return EnvyTemplate(variables).toString();
    } on InvalidTypeException catch (e) {
      throw InvalidGenerationSourceError(
        'Envy supports only limited list of types: int/int?, double/double?, bool/bool?, String/String?. Failing type: ${e.type}. Failing variable: ${e.variable}',
        element: element,
      );
    } on InvalidValueException catch (e) {
      throw InvalidGenerationSourceError(
        'Type ${e.type} does not support value ${e.value}. Failing variable: ${e.variable}',
        element: element,
      );
    }
  }

  ClassElement _getClassElement(Element element) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@envy can only be applied on classes. Failing element: ${element.name}',
        element: element,
      );
    }

    return element;
  }

  List<FieldElement> _getAllFields(ClassElement cls) {
    return cls.fields
        .where((f) => f.hasInitializer && f.hasVariableAnnotation)
        .toList();
  }

  List<PropertyAccessorElement> _getAllGetters(ClassElement cls) {
    return cls.accessors
        .where((a) => a.isGetter && a.hasVariableAnnotation)
        .toList();
  }
}

extension on Element {
  bool get hasVariableAnnotation {
    return const TypeChecker.fromRuntime(Variable).hasAnnotationOf(
      this,
      throwOnUnresolved: false,
    );
  }
}
