import 'package:easychat/models/message.dart';
import 'package:equatable/equatable.dart';

abstract class ChatRoomState extends Equatable {
  const ChatRoomState();

  @override
  List<Object> get props => [];
}

class ChatRoomInitial extends ChatRoomState {}

class ChatRoomLoading extends ChatRoomState {}

class ChatRoomLoaded extends ChatRoomState {
  final List<Message> messages;

  ChatRoomLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatRoomError extends ChatRoomState {
  final String message;

  ChatRoomError(this.message);

  @override
  List<Object> get props => [message];
}
