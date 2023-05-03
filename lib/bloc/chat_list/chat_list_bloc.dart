// Import relevant packages and files
import 'package:easychat/bloc/chat_list/chat_list_event.dart';
import 'package:easychat/bloc/chat_list/chat_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easychat/models/chat_room.dart';
import 'package:easychat/repositories/chat_repository.dart';

// Define chat list states and events here

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository _chatRepository;

  ChatListBloc(this._chatRepository) : super(ChatListInitial()) {
    on<ChatListLoad>((event, emit) async {
      // Handle chat list load event
      emit(ChatListLoading());
      try {
        final List<ChatRoom> chatRooms = await _chatRepository.getChatRooms();
        emit(ChatListLoaded(chatRooms));
      } catch (e) {
        emit(ChatListError(e.toString()));
      }
    });
  }
}

