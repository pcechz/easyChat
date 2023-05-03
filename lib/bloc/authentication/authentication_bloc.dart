// Import relevant packages and files
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easychat/repositories/authentication_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

// Define authentication states and events here

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easychat/bloc/authentication/authentication_event.dart';
import 'package:easychat/bloc/authentication/authentication_state.dart';
import 'package:easychat/models/user.dart';
import 'package:easychat/repositories/authentication_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository) : super(AuthenticationInitial()) {
    on<AuthenticationSignIn>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final AppUser user = await _authenticationRepository.signIn();
        emit(AuthenticationSuccess(user));
      } catch (e) {
        emit(AuthenticationFailure(e.toString()));
      }
    });

    on<AuthenticationSignUp>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final AppUser user = await _authenticationRepository.signUp();
        emit(AuthenticationSuccess(user));
      } catch (e) {
        emit(AuthenticationFailure(e.toString()));
      }
    });

    on<AuthenticationSignOut>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        await _authenticationRepository.signOut();
        emit(AuthenticationInitial());
      } catch (e) {
        emit(AuthenticationFailure(e.toString()));
      }
    });
  }
}
