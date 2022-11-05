import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mirea_db/constants/all_roles_constants.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(FirebaseAuth.instance.currentUser?.email.toString() ??
              'не удалось загрузить пользователя'),
          const Text('Ваша Роль:'),
          Text(context.watch<String?>().toString()),
        ],
      ),
    );
  }
}
