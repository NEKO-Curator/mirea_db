import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<String> getUserDBRole() async {
  //Может сделать Stream?
  try {
    FirebaseAuth.instance.currentUser!.uid;
    var url = Uri.https(
        'http://37.140.198.195:8080/getuser/HhjqVUNrHzWT4oMUxMnMedTViq92');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var currentUserRole = jsonResponse['role'];
      return currentUserRole;
    } else {
      return 'error';
    }
  } catch (e) {
    return 'error';
  }
}
