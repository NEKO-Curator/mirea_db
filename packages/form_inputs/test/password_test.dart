// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/src/password.dart';

void main() {
  group('Тестирование валидации пароля:', () {
    test(
        'Пароль от 8 символов, только цифры и латиница, одна заглавная и цифра',
        () {
      expect(Password.dirty('testtest').valid, false);
      expect(Password.dirty('Akronafed').valid, false);
      expect(Password.dirty('123456789').valid, false);
      expect(Password.dirty('_+Akronafed1').valid, false);
      expect(Password.dirty('Akronafed1').valid, true);
    });
  });
}
