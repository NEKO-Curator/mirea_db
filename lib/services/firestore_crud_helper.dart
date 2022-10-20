
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mirea_db_2/model/firestore_pos_model.dart';

class FireStoreHelper {
  static CollectionReference getAllFirestorePos() {
    final CollectionReference pos =
        FirebaseFirestore.instance.collection('Pos');
    return pos;
  }

  static Future addFireStorePos(FirestorePosModel pos) async {
    await getAllFirestorePos().add(pos.toJson());
  }

  static Future deleteFireStorePos(String posId) async {
    await getAllFirestorePos().doc(posId).delete();
  }

  static Future updateFireStorePos(FirestorePosModel pos, String posId) async {
    await getAllFirestorePos().doc(posId).update(pos.toJson());
  }
}
