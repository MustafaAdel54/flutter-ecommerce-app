import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouriteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> toggleFavorite(int productId) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final docRef = _firestore.collection('favorites').doc(user.uid);
    final doc = await docRef.get();

    if (doc.exists) {
      List<dynamic> products = doc.data()?['productIds'] ?? [];
      if (products.contains(productId)) {
        await docRef.update({
          'productIds': FieldValue.arrayRemove([productId]),
        });
        return false;
      } else {
        await docRef.update({
          'productIds': FieldValue.arrayUnion([productId]),
        });
        return true;
      }
    } else {
      await docRef.set({
        'productIds': [productId],
      });
      return true;
    }
  }

  Stream<List<int>> getFavoriteIds() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _firestore.collection('favorites').doc(user.uid).snapshots().map((
      snapshot,
    ) {
      return List<int>.from(snapshot.data()?['productIds'] ?? []);
    });
  }
}
