import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mirea_db_2/model/pos_model.dart';
import 'package:mirea_db_2/screens/firestore_screens/firestore_card_detail_page.dart';
import 'package:mirea_db_2/screens/sql_screens/card_detail.dart';
import 'package:mirea_db_2/screens/firestore_screens/firestore_cards_page.dart';
import 'package:mirea_db_2/screens/sql_screens/local_cards_page.dart';
import 'package:mirea_db_2/screens/login_screen.dart';

import '../services/db_helper.dart';
import '../widgets/pos_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final colorScheme = ColorScheme;
  final textTheme = ColorScheme;
  int _currentIndex = 3;
  //int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 3
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
      floatingActionButton: _currentIndex != 3
          ? FloatingActionButton.extended(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _currentIndex == 0
                        ? const CardDetail()
                        : (_currentIndex == 1
                            ? Container()
                            : const FireStoreCardDetail()),
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
            label: 'SPRING',
            icon: Icon(Icons.cloud),
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
      return LocalCardsWidget(
        key: UniqueKey(), //пригодились в жизни ключи
      );
    } else if (_currentIndex == 1) {
      return Container();
    } else if (_currentIndex == 2) {
      return FireStoreCardsWidget();
    } else {
      return Container();
    }
  }
}
