import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/feature/home/data/models/dashboard_model.dart';
import 'package:flutter_application_1/feature/home/data/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit({required HomeRepository repository})
      : _repository = repository,
        super(HomeInitial());

  Future<void> getDashboardData() async {
    emit(HomeLoading());
    try {
      final response = await _repository.getDashboardData();
      if (isClosed) return;
      if (response.isSuccess && response.data is DashboardModel) {
        emit(HomeSuccess(response.data as DashboardModel));
      } else {
        emit(HomeFailure(response.message ?? 'Failed to load dashboard data'));
      }
    } catch (e) {
      if (!isClosed) emit(HomeFailure(e.toString()));
    }
  }
}
