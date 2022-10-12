// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FireStoreCardsPage extends StatefulWidget {
//   const FireStoreCardsPage({super.key});

//   @override
//   State<FireStoreCardsPage> createState() => _FireStoreCardsPageState();
// }

// class _FireStoreCardsPageState extends State<FireStoreCardsPage> {
//   List FMs = List.empty();
//   String title = "";
//   String description = "";
//   @override
//   void initState() {
//     super.initState();
//     FMs = ["Hello", "Hey There"];
//   }

//   createFM() {
//     DocumentReference documentReference =
//         FirebaseFirestore.instance.collection("FireStoreModel").doc(title);

//     Map<String, String> FMList = {"Title": title, "Desc": description};

//     documentReference.set(FMList).whenComplete(() => print("сохранено"));
//   }

//   deleteFM(item) {
//     DocumentReference documentReference =
//         FirebaseFirestore.instance.collection("FireStoreModel").doc(item);

//     documentReference.delete().whenComplete(() => print("удалено"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: firestoreFloatingButton(),
//       body: StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance.collection("FireStoreModel").snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Text('что-то пошло не так...');
//           } else if (snapshot.hasData || snapshot.data != null) {
//             return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: snapshot.data?.docs.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   QueryDocumentSnapshot<Object?>? documentSnapshot =
//                       snapshot.data?.docs[index];
//                   return Dismissible(
//                       key: Key(index.toString()),
//                       child: Card(
//                         elevation: 4,
//                         child: ListTile(
//                           title: Text((documentSnapshot != null)
//                               ? (documentSnapshot["Title"])
//                               : ""),
//                           subtitle: Text((documentSnapshot != null)
//                               ? ((documentSnapshot["Desc"] != null)
//                                   ? documentSnapshot["Desc"]
//                                   : "")
//                               : ""),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.delete),
//                             color: Colors.red,
//                             onPressed: () {
//                               setState(() {
//                                 deleteFM((documentSnapshot != null)
//                                     ? (documentSnapshot["Title"])
//                                     : "");
//                               });
//                             },
//                           ),
//                         ),
//                       ));
//                 });
//           }
//           return const Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(
//                 Colors.red,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   FloatingActionButton firestoreFloatingButton() {
//     return FloatingActionButton(
//       onPressed: () {
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 title: const Text("Add FM"),
//                 content: Container(
//                   width: 400,
//                   height: 100,
//                   child: Column(
//                     children: [
//                       TextField(
//                         onChanged: (String value) {
//                           title = value;
//                         },
//                       ),
//                       TextField(
//                         onChanged: (String value) {
//                           description = value;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: <Widget>[
//                   TextButton(
//                       onPressed: () {
//                         setState(() {
//                           createFM();
//                         });
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text("Добавить"))
//                 ],
//               );
//             });
//       },
//       child: const Icon(
//         Icons.add,
//         color: Colors.white,
//       ),
//     );
//   }
// }
