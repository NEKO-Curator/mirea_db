// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/src/email.dart';

void main() {
  group('Тестирование валидации Email:', () {
    test('Email имеет минимум 1 символ + @ + доменное имя', () {
      expect(Email.dirty('testtest').valid, false);
      expect(Email.dirty('Akronafed@').valid, false);
      expect(Email.dirty('1@.com').valid, false);
      expect(Email.dirty('@gmail.com').valid, false);
      expect(Email.dirty('akrofed@gmail.com').valid, true);
    });
  });
}
