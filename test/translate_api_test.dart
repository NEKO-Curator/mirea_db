import 'package:flutter_test/flutter_test.dart';
import 'package:mirea_db/api/translate_api.dart';

void main() {
  group('Тестирование апи метода возвращающего перевод', () {
    test('При пустом запросе возвращает пустой ответ', () async {
      final testResponse = await fetchTranslate('');
      expect(testResponse, '');
    });

    test('При не пустом запросе должен возвращать перевод с китайского',
        () async {
      final testResponse = await fetchTranslate('test');
      expect(testResponse, '测试');
    });

    test(
        'Даже при отсутсвии букв должен отправлять запрос и возвращать значение',
        () async {
      final testResponse = await fetchTranslate('1234+');
      expect(testResponse, '1234+');
    });
  });
}
