import 'package:equatable/equatable.dart';

import '../../models/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final AppUser user;

  UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserListLoading extends UserState {}

class UserListLoaded extends UserState {
  final List<AppUser> users;

  UserListLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserError extends UserState {
  final String error;

  UserError(this.error);

  @override
  List<Object> get props => [error];
}
