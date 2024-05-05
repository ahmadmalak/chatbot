import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class HistoryService {
  var database = FirebaseFirestore.instance;
  var firebaseAuth = FirebaseAuth.instance;

  Future<List<DocumentSnapshot>> fetchUserHistories() async {
    String? id = firebaseAuth.currentUser?.uid;
    return await database
        .collection('histories')
        .where('userId', isEqualTo: id)
        .get()
        .then((value) => value.docs);
  }

  Future<void> addInputUser(
    String input,
  ) async {
    final uuid = const Uuid().v4();
    String? userId = firebaseAuth.currentUser?.uid;
    await database.collection('histories').doc(uuid).set({
      'id': uuid,
      'input': input,
      "userId": userId,
      "date": DateTime.now().toString(),
    });
  }
}
