import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/space_model.dart';
import '../data/repository/space_repository.dart';
import 'space_state.dart';

class SpaceCubit extends Cubit<SpaceState> {
  final SpaceRepository repository;

  SpaceCubit(this.repository) : super(SpaceInitial());

  Future<void> loadSpaces() async {
    try {
      emit(SpaceLoading());
      final spaces = await repository.getSpaces();
      if (isClosed) return;
      emit(SpaceLoaded(spaces));
    } catch (e) {
      if (!isClosed) emit(SpaceError(e.toString()));
    }
  }

  Future<void> loadSpaceDetail(String id) async {
    try {
      emit(SpaceLoading());
      final space = await repository.getSpaceById(id);
      if (isClosed) return;
      emit(SpaceDetailLoaded(space));
    } catch (e) {
      if (!isClosed) emit(SpaceError(e.toString()));
    }
  }

  Future<void> createSpace(SpaceModel space) async {
    try {
      emit(SpaceLoading());
      await repository.createSpace(space);
      if (isClosed) return;
      emit(SpaceOperationSuccess('Space created successfully'));
      await loadSpaces();
    } catch (e) {
      if (!isClosed) emit(SpaceError(e.toString()));
    }
  }

  Future<void> updateSpace(SpaceModel space) async {
    try {
      emit(SpaceLoading());
      await repository.updateSpace(space);
      if (isClosed) return;
      emit(SpaceOperationSuccess('Space updated successfully'));
      await loadSpaces();
    } catch (e) {
      if (!isClosed) emit(SpaceError(e.toString()));
    }
  }

  Future<void> deleteSpace(String id) async {
    try {
      emit(SpaceLoading());
      await repository.deleteSpace(id);
      if (isClosed) return;
      emit(SpaceOperationSuccess('Space deleted successfully'));
      await loadSpaces();
    } catch (e) {
      if (!isClosed) emit(SpaceError(e.toString()));
    }
  }

  Future<void> setGoal(String spaceId, double goalAmount) async {
    try {
      emit(SpaceLoading());
      await repository.setGoal(spaceId, goalAmount);
      if (isClosed) return;
      emit(SpaceOperationSuccess('Goal set successfully'));
      await loadSpaces();
    } catch (e) {
      if (!isClosed) emit(SpaceError(e.toString()));
    }
  }
}
