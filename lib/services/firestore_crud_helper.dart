import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mirea_db/model/firestore_pos_model.dart';

class FireStoreHelper {
  static CollectionReference getAllFirestorePos(String collectionName) {
    return FirebaseFirestore.instance.collection(collectionName);
  }

  static Future addFireStorePos(
      FirestorePosModel pos, String collectionName) async {
    await getAllFirestorePos(collectionName).add(pos.toJson());
  }

  static Future deleteFireStorePos(String posId, String collectionName) async {
    await getAllFirestorePos(collectionName).doc(posId).delete();
  }

  static Future updateFireStorePos(
      FirestorePosModel pos, String posId, String collectionName) async {
    await getAllFirestorePos(collectionName).doc(posId).update(pos.toJson());
  }
}
