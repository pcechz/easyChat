import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easychat/bloc/chat_list/chat_list_bloc.dart';
import 'package:easychat/pages/chat_list_page.dart';
import 'package:easychat/pages/sign_in_page.dart';
import 'package:easychat/repositories/authentication_repository.dart';
import 'package:easychat/repositories/chat_repository.dart';
import 'package:easychat/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/chat_room/chat_room_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'bloc/user/user_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository = AuthenticationRepository(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  );
  final ChatRepository chatRepository = ChatRepository(firestore: FirebaseFirestore.instance);
  final UserRepository userRepository = UserRepository(firestore: FirebaseFirestore.instance);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(authenticationRepository),
        ),
        BlocProvider<ChatListBloc>(
          create: (context) => ChatListBloc(chatRepository),
        ),
        BlocProvider<ChatRoomBloc>(
          create: (context) => ChatRoomBloc(chatRepository),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(userRepository),
        ),
      ],
      child: MaterialApp(
        // ...
        home: FutureBuilder<bool>(
          future: authenticationRepository.isUserSignedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.data == true) {
              return ChatListPage();
            } else {
              return SignInPage();
            }
          },
        ),
      ),
    );
  }
}
