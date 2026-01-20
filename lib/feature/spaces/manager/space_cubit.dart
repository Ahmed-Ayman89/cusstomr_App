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
      emit(SpaceLoaded(spaces));
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }

  Future<void> loadSpaceDetail(String id) async {
    try {
      emit(SpaceLoading());
      final space = await repository.getSpaceById(id);
      emit(SpaceDetailLoaded(space));
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }

  Future<void> createSpace(SpaceModel space) async {
    try {
      emit(SpaceLoading());
      await repository.createSpace(space);
      emit(SpaceOperationSuccess('Space created successfully'));
      await loadSpaces();
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }

  Future<void> updateSpace(SpaceModel space) async {
    try {
      emit(SpaceLoading());
      await repository.updateSpace(space);
      emit(SpaceOperationSuccess('Space updated successfully'));
      await loadSpaces();
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }

  Future<void> deleteSpace(String id) async {
    try {
      emit(SpaceLoading());
      await repository.deleteSpace(id);
      emit(SpaceOperationSuccess('Space deleted successfully'));
      await loadSpaces();
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }

  Future<void> setGoal(String spaceId, double goalAmount) async {
    try {
      emit(SpaceLoading());
      await repository.setGoal(spaceId, goalAmount);
      emit(SpaceOperationSuccess('Goal set successfully'));
      await loadSpaces();
    } catch (e) {
      emit(SpaceError(e.toString()));
    }
  }
}
