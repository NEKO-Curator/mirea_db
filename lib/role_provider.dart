import 'package:firebase_auth/firebase_auth.dart';
import 'package:mirea_db/api/user_db_role_api.dart';
import 'package:mirea_db/screens/home_page_bottom_navigation.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

final roleProvider = FutureProvider<String?>(
  initialData: null,
  create: (context) async =>
      await getUserDBRole(FirebaseAuth.instance.currentUser),
  child: const MyHomePage(),
);
