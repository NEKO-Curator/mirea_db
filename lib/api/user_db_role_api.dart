import 'dart:convert' as convert;
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:mirea_db/constants/all_roles_constants.dart';
import 'package:mirea_db/constants/roles_db_api_constants.dart';

Future<String> getUserDBRole(User? user) async {
  try {
    var url = Uri.http('37.140.198.195:8080', '/$getUser/${user!.uid}');
    var response = await http.get(url);
    //log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      return jsonResponse[0]['role'].toString();
    } else {
      return 'error_user';
    }
  } catch (e) {
    log('getUserDBRole => ${e.toString()}');
    return 'error_user';
  }
}

Future<bool> addUserDBRole(User? user) async {
  try {
    var url = Uri.parse('http://37.140.198.195:8080/$addUser');
    var body = convert.jsonEncode(<String, String>{
      'user_id': user!.uid,
      'role': roleStandart,
    });
    var response = await http.post(url, body: body);
    //log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log(response.body.toString());
      return true;
    } else {
      return false;
    }
  } catch (e) {
    log('getUserDBRole => ${e.toString()}');
    return false;
  }
}
