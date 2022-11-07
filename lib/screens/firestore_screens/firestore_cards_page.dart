import 'package:flutter/material.dart';
import 'package:mirea_db/constants/all_roles_constants.dart';
import 'package:mirea_db/widgets/firestore_cards_admin_page.dart';
import 'package:mirea_db/widgets/firestore_no_role_page.dart';
import 'package:provider/provider.dart';

class FireStoreCardsPage extends StatelessWidget {
  const FireStoreCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //log(context.read<String>().toString());
    return context.select((String string) => string == roleAdmin)
        ? firestoreCardsAdminPage()
        : firestoreCardsNoRolePage();
  }
}
