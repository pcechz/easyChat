import 'package:easychat/models/message.dart';
import 'package:equatable/equatable.dart';

abstract class ChatRoomEvent extends Equatable {
  const ChatRoomEvent();

  @override
  List<Object> get props => [];
}

class ChatRoomLoad extends ChatRoomEvent {
  final String chatRoomId;

  ChatRoomLoad(this.chatRoomId);

  @override
  List<Object> get props => [chatRoomId];
}

class ChatRoomSendMessage extends ChatRoomEvent {
  final String chatRoomId;
  final Message message;

  ChatRoomSendMessage({required this.chatRoomId, required this.message});

  @override
  List<Object> get props => [chatRoomId, message];
}
