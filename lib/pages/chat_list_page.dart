// Import relevant packages and files
import 'package:easychat/bloc/chat_list/chat_list_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easychat/pages/chat_room_page.dart';

import '../bloc/chat_list/chat_list_bloc.dart';
import '../bloc/chat_list/chat_list_event.dart';
import '../bloc/user/user_bloc.dart';
import '../bloc/user/user_event.dart';
import '../bloc/user/user_state.dart';
import '../repositories/chat_repository.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatListBloc>().add(ChatListLoad());
  }

  void _showUsersBottomSheet(BuildContext context) {
    context.read<UserBloc>().add(UserListLoad());
    showModalBottomSheet(
        context: context,
        builder: (context) {
      return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
        if (state is UserListLoading) {
          return Center(child: CircularProgressIndicator());
        }
        else if (state is UserListLoaded) {
          return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
            final user = state.users[index];
            return ListTile(
                title: Text(user.displayName ?? ''),
    onTap: () async {
    Navigator.pop(context);
    // Add logic to start a chat with the selected user
    final chatRoomId = await context.read<ChatRepository>().createChatRoom(user.id);
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ChatRoomPage(chatRoom: chatRoomId),
    ),
    );
    },);});}
          else { return SizedBox.shrink();}
          });});}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List'),
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state is ChatListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChatListLoaded) {
            return ListView.builder(
              itemCount: state.chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = state.chatRooms[index];
                return ListTile(
                  title: Text(chatRoom.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatRoomPage(chatRoom: chatRoom),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is ChatListError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUsersBottomSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
