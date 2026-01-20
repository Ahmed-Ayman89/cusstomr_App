import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/support_repository.dart';
import 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  final SupportRepository repository;

  SupportCubit(this.repository) : super(SupportInitial());

  Future<void> fetchSupportInfo() async {
    emit(SupportLoading());
    try {
      final response = await repository.getSupportInfo();
      if (response.success == true && response.data != null) {
        if (!isClosed) emit(SupportLoaded(response.data!));
      } else {
        if (!isClosed) {
          emit(SupportError(
              response.message ?? 'Failed to load support information'));
        }
      }
    } catch (e) {
      if (!isClosed) {
        String errorMessage = e.toString();
        if (errorMessage.startsWith('Exception: ')) {
          errorMessage = errorMessage.substring(11);
        }
        emit(SupportError(errorMessage));
      }
    }
  }
}
