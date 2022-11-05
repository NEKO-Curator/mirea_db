import 'dart:async';
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:mirea_db/model/data_take_model.dart';

Future<String> fetchTranslate(String text) async {
  var headers = {
    'content-type': 'application/json',
    'X-RapidAPI-Key': 'e0cfc51f6emshe3ad569772cd49ap1a4198jsn3e02d072de69',
    'X-RapidAPI-Host': 'microsoft-translator-text.p.rapidapi.com'
  };
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://microsoft-translator-text.p.rapidapi.com/translate?to[0]=zh&api-version=3.0'));
  request.body = json.encode([
    {"Text": text}
  ]);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var endResponse = await http.Response.fromStream(response);
  if (response.statusCode == 200) {
    var temp = DataTake.fromJson(await json.decode(endResponse.body)[0]);
    return temp.getTranslationText();
  } else {
    // print(response.reasonPhrase);
    return 'null';
  }
}
