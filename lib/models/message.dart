import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? id;
  final String content;
  final String senderId;
  final DateTime timestamp;

  Message({this.id, required this.content, required this.senderId, required this.timestamp});

  factory Message.fromMap(Map<String, dynamic> data, String documentId) {
    return Message(
      id: documentId,
      content: data['content'] ?? '',
      senderId: data['senderId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'senderId': senderId,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
