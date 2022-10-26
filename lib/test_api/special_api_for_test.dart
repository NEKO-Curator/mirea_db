import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mirea_db/test_api/album_model.dart';

Future<Album> fetchAlbum(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('ошибка загрузки');
  }
}
