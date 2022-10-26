import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mirea_db/test_api/album_model.dart';
import 'package:mirea_db/test_api/special_api_for_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'translate_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('Удачный ответ', () async {
      final client = MockClient();

      //используем мокито для возврата удачного ответа
      // provided http.Client.
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
              http.Response('{"userId": 1, "id": 2, "title": "test"}', 200));

      expect(await fetchAlbum(client), isA<Album>());
    });

    test('Неудачный ответ бросит исключение', () {
      final client = MockClient();

      // используем мокито чтобы вызвать неудачный ответ
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
