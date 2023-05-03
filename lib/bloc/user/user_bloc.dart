import 'package:easychat/bloc/user/user_event.dart';
import 'package:easychat/bloc/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';
import '../../repositories/chat_repository.dart';
import '../../repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserInitial()) {
    on<UserLoad>((event, emit) async {
      emit(UserLoading());
      try {
        final AppUser user = await _userRepository.getUser(event.userId);
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<UserListLoad>((event, emit) async {
      emit(UserListLoading());
      try {
        final List<AppUser> users = await _userRepository.getUsers();
        emit(UserListLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
