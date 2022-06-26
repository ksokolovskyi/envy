import 'package:envy_generator/src/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  test('FileNotFoundException', () {
    expect(
      const FileNotFoundException('.env'),
      isA<FileNotFoundException>()
          .having(
            (e) => e.path,
            'path',
            '.env',
          )
          .having(
            (e) => e.toString(),
            'toString',
            'FileNotFoundException: file not found at path .env',
          ),
    );
  });

  test('InvalidTypeException', () {
    expect(
      const InvalidTypeException(type: 'MyType', variable: 'myVar'),
      isA<InvalidTypeException>()
          .having((e) => e.type, 'type', 'MyType')
          .having((e) => e.variable, 'variable', 'myVar')
          .having(
            (e) => e.toString(),
            'toString',
            'InvalidTypeException: type MyType is not supported',
          ),
    );
  });

  test('InvalidTypeException', () {
    expect(
      const InvalidValueException(
        type: 'int',
        value: 'hello',
        variable: 'myVar',
      ),
      isA<InvalidValueException>()
          .having((e) => e.type, 'type', 'int')
          .having((e) => e.value, 'value', 'hello')
          .having((e) => e.variable, 'variable', 'myVar')
          .having(
            (e) => e.toString(),
            'toString',
            'InvalidValueException: type int does not support value hello',
          ),
    );
  });
}
