import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRepo {
  Future<bool> createUser(String uid, String email, String username) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username.trim(),
        'email': email.trim(),
        'createdAt': DateTime.now(),
        'uid': uid,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
