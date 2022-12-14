import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mirea_db/model/firestore_pos_model.dart';
import 'package:mirea_db/screens/firestore_screens/firestore_card_detail_page.dart';
import 'package:mirea_db/services/firestore_crud_helper.dart';

Widget firestoreCardsAdminPage() {
  return StreamBuilder(
    stream: FireStoreHelper.getAllFirestorePos('Pos')
        .snapshots(), //build connection
    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
      if (streamSnapshot.hasData) {
        return streamSnapshot.data!.docs.isNotEmpty
            ? ListView.builder(
                itemCount: streamSnapshot.data!.docs.length, //number of rows
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FireStoreCardDetail(
                              firestorePos: FirestorePosModel.fromJson(
                                  documentSnapshot.data()
                                      as Map<String, dynamic>),
                              docId: documentSnapshot.id.toString(),
                            ),
                          ),
                        );
                      },
                      title: Text(documentSnapshot['title']),
                      subtitle:
                          Text('${documentSnapshot['price'].toString()}p'),
                      onLongPress: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    const Text('??????????????, ?????? ???????????? ???????????????'),
                                actions: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () async {
                                      await FireStoreHelper.deleteFireStorePos(
                                          documentSnapshot.id.toString(),
                                          'Pos');
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    },
                                    child: const Text('????'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('??????'),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  );
                },
              )
            : const Center(
                child: Text('???????? ?????? ??????????????'),
              );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
