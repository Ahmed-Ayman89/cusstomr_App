import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/feature/spaces/data/models/space_model.dart';
import 'package:flutter_application_1/feature/spaces/data/repositories/spaces_repository.dart';

part 'spaces_state.dart';

class SpacesCubit extends Cubit<SpacesState> {
  final SpacesRepository _repository;

  SpacesCubit({required SpacesRepository repository})
      : _repository = repository,
        super(SpacesInitial());

  Future<void> getSpaces() async {
    emit(SpacesLoading());
    try {
      final response = await _repository.getSpaces();
      if (isClosed) return;
      if (response.isSuccess && response.data is SpacesResponseModel) {
        emit(SpacesSuccess(response.data as SpacesResponseModel));
      } else {
        emit(SpacesFailure(response.message ?? 'Failed to load spaces'));
      }
    } catch (e) {
      if (!isClosed) emit(SpacesFailure(e.toString()));
    }
  }

  Future<void> createSpace({
    required String name,
    required String? image,
    required double targetAmount,
    required String deadline,
    required String passcode,
  }) async {
    emit(SpacesLoading());
    try {
      final response = await _repository.createSpace(
        name: name,
        image: image,
        targetAmount: targetAmount,
        deadline: deadline,
        passcode: passcode,
      );
      if (isClosed) return;

      if (response.isSuccess) {
        // Refresh list after creation
        await getSpaces();
        // emitting Success state might be handled by getSpaces emitting SpacesSuccess,
        // but if we need a specific "Creation Success" events we might need a separate stream or state.
        // For now, refreshing the list is usually enough for the UI to update.
        // However, to close the screen/dialog, we might want to emit a specific state or relying on the list update.
        // Let's assume the UI listens for SpacesSuccess or we add a one-off event.
        // Actually, let's keep it simple: refreshing gets the new list.
        // If we want to show a tailored message, we might need a mixin or separate state property.
        // Re-emitting SpacesSuccess is fine.
      } else {
        emit(SpacesFailure(response.message ?? 'Failed to create space'));
      }
    } catch (e) {
      if (!isClosed) emit(SpacesFailure(e.toString()));
    }
  }
}
