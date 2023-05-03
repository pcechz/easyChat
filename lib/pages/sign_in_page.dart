// Import relevant packages and files
import 'package:easychat/bloc/authentication/authentication_event.dart';
import 'package:easychat/bloc/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easychat/bloc/authentication/authentication_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easychat/pages/chat_list_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthenticationSuccess();
  }

  void _checkAuthenticationSuccess() {
    context.read<AuthenticationBloc>().stream.listen((state) {
      if (state is AuthenticationSuccess) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ChatListPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign In Page'),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(AuthenticationSignIn());
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
