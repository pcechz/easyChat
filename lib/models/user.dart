import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String? displayName;
  final String? email;
  final String? photoUrl;

  AppUser({required this.id, this.displayName, this.email, this.photoUrl});

  factory AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return AppUser(
      id: snapshot.id,
      displayName: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
