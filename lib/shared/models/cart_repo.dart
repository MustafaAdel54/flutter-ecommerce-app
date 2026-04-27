import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<Map<String, int>> fetchCartOnce() async {
    final user = _auth.currentUser;
    if (user == null) return {};

    final doc = await _firestore.collection('cart').doc(user.uid).get();
    if (!doc.exists) return {};

    final data = doc.data();
    return Map<String, int>.from(data?['items'] ?? {});
  }

  Future<void> addToCart(int productId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore.collection('cart').doc(user.uid);

    await docRef.set({
      'items': {'$productId': FieldValue.increment(1)},
    }, SetOptions(merge: true));
  }

  Future<void> removeFromCart(int productId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore.collection('cart').doc(user.uid);

    await docRef.update({'items.$productId': FieldValue.delete()});
  }

  Future<void> increaseInCart(int productId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore.collection('cart').doc(user.uid);

    await docRef.update({'items.$productId': FieldValue.increment(1)});
  }

  Future<void> decreaseFromCart(int productId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('cart').doc(user.uid).update({
      'items.$productId': FieldValue.increment(-1),
    });
  }
}
