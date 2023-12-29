import 'package:pharmageddon_mobile/core/class/parent_state.dart';

abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NewNotification extends NotificationState {
  final ParentState state;

  NewNotification(this.state);
}
