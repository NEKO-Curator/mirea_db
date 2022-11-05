import 'package:mirea_db/api/roles_db_api.dart';
import 'package:mirea_db/screens/home_page_bottom_navigation.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

final roleProvider = FutureProvider<String?>(
  initialData: null,
  create: (context) => getUserDBRole(),
  lazy: false,
  child: const MyHomePage(),
);
