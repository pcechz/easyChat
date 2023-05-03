import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationSignIn extends AuthenticationEvent {}

class AuthenticationSignUp extends AuthenticationEvent {}

class AuthenticationSignOut extends AuthenticationEvent {}
