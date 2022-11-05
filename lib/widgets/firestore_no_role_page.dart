import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mirea_db/services/firestore_crud_helper.dart';

Widget firestoreCardsNoRolePage() {
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
                      title: Text(documentSnapshot['title']),
                      subtitle:
                          Text('${documentSnapshot['price'].toString()}p'),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('Пока нет записей'),
              );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
