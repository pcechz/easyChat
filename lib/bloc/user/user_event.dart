abstract class UserEvent {}

class UserLoad extends UserEvent {
  final String userId;

  UserLoad(this.userId);
}
class UserListLoad extends UserEvent {

  UserListLoad();
}