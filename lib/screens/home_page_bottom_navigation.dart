import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mirea_db/constants/all_roles_constants.dart';
import 'package:mirea_db/screens/firestore_screens/firestore_card_detail_page.dart';
import 'package:mirea_db/screens/profile_page.dart';
import 'package:mirea_db/screens/sql_screens/card_detail.dart';
import 'package:mirea_db/screens/firestore_screens/firestore_cards_page.dart';
import 'package:mirea_db/screens/login_screen.dart';
import 'package:mirea_db/widgets/local_cards_admin_page.dart';
import 'package:mirea_db/widgets/local_no_role_page.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final colorScheme = ColorScheme;
  final textTheme = ColorScheme;
  int _currentIndex = 2;
  //int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 2
          ? AppBar(
              backgroundColor: Colors.pink,
              automaticallyImplyLeading: false,
              title: const Text('MYON Cafe'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  icon: const Icon(Icons.logout),
                )
              ],
            )
          : AppBar(
              backgroundColor: Colors.pink,
              automaticallyImplyLeading: false,
              title: const Text('MYON Cafe'),
              centerTitle: true,
            ),
      floatingActionButton: _currentIndex != 2 &&
              context.select((String string) => string == roleAdmin)
          ? FloatingActionButton.extended(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _currentIndex == 0
                        ? const CardDetail()
                        : (const FireStoreCardDetail.createNewDetail('Pos')),
                  ),
                ).then((_) => {
                      setState(() {}),
                    });
              },
              label: const Text('Добавить'),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.pink,
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            label: 'LOCAL',
            icon: Icon(Icons.wheelchair_pickup),
          ),
          const BottomNavigationBarItem(
            label: 'FIRESTORE',
            icon: Icon(Icons.local_fire_department),
          ),
          const BottomNavigationBarItem(
            label: 'PROFILE',
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (_currentIndex == 0) {
      return context.select((String string) => string == roleAdmin)
          ? LocalCardsAdminPage(
              key: UniqueKey(),
            )
          : LocalCardsNoRolePage(
              key: UniqueKey(),
            );
    } else if (_currentIndex == 1) {
      return const FireStoreCardsPage();
    } else {
      return const ProfilePage();
    }
  }
}
