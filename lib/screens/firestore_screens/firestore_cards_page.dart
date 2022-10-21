import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mirea_db_2/model/firestore_pos_model.dart';
import 'package:mirea_db_2/screens/firestore_screens/firestore_card_detail_page.dart';
import 'package:mirea_db_2/services/firestore_crud_helper.dart';

class FireStoreCardsWidget extends StatelessWidget {
  const FireStoreCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FireStoreHelper.getAllFirestorePos().snapshots(), //build connection
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length, //number of rows
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  onTap: () async {
                    log(documentSnapshot.id.toString());
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FireStoreCardDetail(
                          firestorePos: FirestorePosModel.fromJson(
                              documentSnapshot.data() as Map<String, dynamic>),
                          docId: documentSnapshot.id.toString(),
                        ),
                      ),
                    );
                  },
                  title: Text(documentSnapshot['title']),
                  subtitle: Text('${documentSnapshot['price'].toString()}p'),
                  onLongPress: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Уверены, что хотите удалить?'),
                            actions: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () async {
                                  await FireStoreHelper.deleteFireStorePos(
                                      documentSnapshot.id.toString());
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                },
                                child: const Text('Да'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Нет'),
                              ),
                            ],
                          );
                        });
                  },
                ),
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
