// Import relevant packages and files
import 'package:easychat/bloc/authentication/authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easychat/bloc/authentication/authentication_bloc.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthenticationBloc>().add(AuthenticationSignUp());
          },

          child: Text('Sign Up with Google'),
        ),
      ),
    );
  }
}
