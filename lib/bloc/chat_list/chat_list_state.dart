import 'package:easychat/models/chat_room.dart';
import 'package:equatable/equatable.dart';

abstract class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object> get props => [];
}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<ChatRoom> chatRooms;

  ChatListLoaded(this.chatRooms);

  @override
  List<Object> get props => [chatRooms];
}

class ChatListError extends ChatListState {
  final String message;

  ChatListError(this.message);

  @override
  List<Object> get props => [message];
}
