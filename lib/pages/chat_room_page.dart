// Import relevant packages and files
import 'package:easychat/bloc/chat_room/chat_room_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easychat/models/chat_room.dart';
import 'package:easychat/models/message.dart';

import '../bloc/chat_room/chat_room_bloc.dart';
import '../bloc/chat_room/chat_room_event.dart';

class ChatRoomPage extends StatefulWidget {
  final ChatRoom chatRoom;

  ChatRoomPage({required this.chatRoom});

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatRoomBloc>().add(ChatRoomLoad(widget.chatRoom.id));
  }

  void _sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      context.read<ChatRoomBloc>().add(
        ChatRoomSendMessage(
          chatRoomId: widget.chatRoom.id,
          message: Message(
            content: _textEditingController.text,
            timestamp: DateTime.now(),
            // Add the current user's id as the sender id
            senderId: "currentUserId",
          ),
        ),
      );
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatRoom.name),
      ),
      body: Column(
        children: [
        Expanded(
        child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
          builder: (context, state) {
      if (state is ChatRoomLoading) {
      return Center(child: CircularProgressIndicator());
      } else if (state is ChatRoomLoaded) {
      return ListView.builder(
      itemCount: state.messages.length,
      itemBuilder: (context, index) {
      final message = state.messages[index];
      return ListTile(
      title: Text(message.content),
      subtitle: Text(message.timestamp.toIso8601String()),
      );
      },
      );
      } else if (state is ChatRoomError) {
      return Center(child: Text(state.message));
      }
      return Container();
      },
      ),
    ),
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
    children: [
    Expanded(
    child: TextField(
    controller: _textEditingController,
      decoration: InputDecoration(
        hintText: 'Type your message...',
      ),
    ),
    ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: _sendMessage,
      ),
    ],
    ),
    ),
        ],
      ),
    );
  }
}