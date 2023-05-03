// Import relevant packages and files
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easychat/models/chat_room.dart';
import 'package:easychat/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  final FirebaseFirestore _firestore;

  ChatRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future<List<ChatRoom>> getChatRooms() async {
    final querySnapshot = await _firestore.collection('chatRooms').get();
    return querySnapshot.docs
        .map((doc) => ChatRoom.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<Message>> getMessages(String chatRoomId) async {
    final querySnapshot = await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => Message.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> sendMessage(String chatRoomId, Message message) async {
    await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toMap());
  }

  Future<ChatRoom> createChatRoom(String otherUserId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User not signed in');
    }

    // Create chat room id
    final chatRoomId = (currentUser.uid.hashCode <= otherUserId.hashCode)
        ? '${currentUser.uid}-$otherUserId'
        : '$otherUserId-${currentUser.uid}';

    // Create chat room in Firestore
    final chatRoomRef = _firestore.collection('chatRooms').doc(chatRoomId);
    final chatRoomSnapshot = await chatRoomRef.get();

    if (!chatRoomSnapshot.exists) {
      await chatRoomRef.set({
        'members': [currentUser.uid, otherUserId],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    // Get the chat room data
    final chatRoomData = (await chatRoomRef.get()).data() as Map<String, dynamic>;

    // Create a ChatRoom object
    final chatRoom = ChatRoom(
      id: chatRoomId, name: chatRoomData['name'] as String,
    );

    return chatRoom;
  }
}