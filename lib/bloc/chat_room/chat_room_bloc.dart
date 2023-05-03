// Import relevant packages and files
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easychat/models/message.dart';
import 'package:easychat/repositories/chat_repository.dart';

import 'chat_room_event.dart';
import 'chat_room_state.dart';

// Define chat room states and events here

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final ChatRepository _chatRepository;

  ChatRoomBloc(this._chatRepository) : super(ChatRoomInitial()) {
    on<ChatRoomLoad>((event, emit) async {
      // Handle chat room load event
      emit(ChatRoomLoading());
      try {
        final List<Message> messages = await _chatRepository.getMessages(event.chatRoomId);
        emit(ChatRoomLoaded(messages));
      } catch (e) {
        emit(ChatRoomError(e.toString()));
      }
    });

    on<ChatRoomSendMessage>((event, emit) async {
      // Handle send message event
      try {
        await _chatRepository.sendMessage(event.chatRoomId, event.message);
      } catch (e) {
        emit(ChatRoomError(e.toString()));
      }
    });
  }
}
