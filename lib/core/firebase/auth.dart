import 'package:ask_pdf/services/constants.dart';
import 'package:ask_pdf/widgets/toastmessag.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  var database = FirebaseFirestore.instance;
  var firebaseAuth = FirebaseAuth.instance;

  //fetch user information
  Future<DocumentSnapshot> fetchUserInfo() async {
    //get user id
    String? id = firebaseAuth.currentUser?.uid;
    return await database.collection('users').doc(id).get();
  }

//create account user
  Future<UserCredential?> onCreateUserAccount({
    required String email,
    required String phone,
    required String password,
    required String name,
    required address,
    required donorId,
    required String bloodType,
    required BuildContext context,
    required List<Map<String, dynamic>> optionMaps,
  }) async {
    // Create a list of maps.

    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        database
            .collection('users')
            .doc(
              userCredential.user?.uid,
            )
            .set({
          'id': userCredential.user?.uid,
          'name': name,
          'email': userCredential.user?.email,
          'phoneNumber': phone,
          'imageProfile': '',
        }).then((value) async {
          debugPrint('success addUserToFireStore');
        }).catchError((error) {
          debugPrint('Error adding profile to db $error');
        });
        box.write('userEmail', userCredential.user!.email);
        box.write('userId', userCredential.user!.uid.toString());
      }
      return userCredential;
    } catch (error) {
      if (error.toString().contains('[firebase_auth/wrong-password]')) {
        showToast(message: 'invalid password', context: context);
      } else if (error.toString().contains('[firebase_auth/user-not-found]')) {
        showToast(message: 'invalid email', context: context);
      } else {
        showToast(message: 'oops something went wrong ', context: context);
      }
      debugPrint('Error: $error');
    }
    return null;
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (error) {
      if (error.toString().contains('[firebase_auth/wrong-password]')) {
        BotToast.closeAllLoading();
        showToast(
          message: error.toString(),
          context: context,
        );
      } else if (error.toString().contains('[firebase_auth/user-not-found]')) {
        BotToast.closeAllLoading();
        showToast(
          message: error.toString(),
          context: context,
        );
      } else if (error
          .toString()
          .contains('[firebase_auth/too-many-requests]')) {
        BotToast.closeAllLoading();
        showToast(
          message: error.toString(),
          context: context,
        );
      } else if (error.toString().contains('[firebase_auth/user-disabled]')) {
        BotToast.closeAllLoading();
        showToast(
          message: error.toString(),
          context: context,
        );
      } else if (error.toString().contains('[firebase_auth/invalid-email]')) {
        BotToast.closeAllLoading();
        showToast(
          message: error.toString(),
          context: context,
        );
      } else {
        BotToast.closeAllLoading();
        showToast(
          message: 'oops something went wrong ',
          context: context,
        );
      }
      debugPrint('Error: $error');
      return null;
    }
  }

  Future<void> updateUserInfo({
    required String name,
    required String phoneNumber,
    required String address,
  }) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    await database.collection('users').doc(userId).update({
      'address': address,
      'name': name,
      'phoneNumber': phoneNumber,
    });
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    box.erase();
  }

  Future<void> addUserToFireStore({
    required String id,
    required String name,
    required String email,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    final db = FirebaseFirestore.instance;
    box.write('userId', id);
    db.collection('users').doc(id).set({
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageProfile': '',
    });
  }
}
