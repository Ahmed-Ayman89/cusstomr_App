part of 'notifications_cubit.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationsSuccess(this.notifications);
}

class NotificationsFailure extends NotificationsState {
  final String message;
  NotificationsFailure(this.message);
}
