import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future<List<AppUser>> getUsers() async {
    final usersSnapshot = await _firestore.collection('users').get();
    return usersSnapshot.docs.map((doc) => AppUser.fromSnapshot(doc)).toList();
  }

  Future<AppUser> getUser(String userId) async {
    DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();
    return AppUser.fromSnapshot(userSnapshot);
  }
}
