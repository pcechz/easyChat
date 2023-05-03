class ChatRoom {
  final String id;
  final String name;

  ChatRoom({required this.id, required this.name});

  factory ChatRoom.fromMap(Map<String, dynamic> data, String documentId) {
    return ChatRoom(
      id: documentId,
      name: data['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
