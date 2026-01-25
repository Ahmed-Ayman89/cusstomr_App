import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/feature/notifications/data/models/notification_model.dart';
import 'package:flutter_application_1/feature/notifications/data/repositories/notifications_repository.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _repository;

  NotificationsCubit({required NotificationsRepository repository})
      : _repository = repository,
        super(NotificationsInitial());

  Future<void> getNotifications() async {
    emit(NotificationsLoading());
    try {
      final response = await _repository.getNotifications();
      if (isClosed) return;
      if (response.isSuccess && response.data is NotificationsResponseModel) {
        final data = response.data as NotificationsResponseModel;
        emit(NotificationsSuccess(data.notifications));
      } else {
        emit(NotificationsFailure(
            response.message ?? 'Failed to load notifications'));
      }
    } catch (e) {
      if (!isClosed) emit(NotificationsFailure(e.toString()));
    }
  }
}
