import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/feature/spaces/data/models/space_model.dart';
import 'package:flutter_application_1/feature/spaces/data/repositories/spaces_repository.dart';

part 'space_detail_state.dart';

class SpaceDetailCubit extends Cubit<SpaceDetailState> {
  final SpacesRepository _repository;

  SpaceDetailCubit({required SpacesRepository repository})
      : _repository = repository,
        super(SpaceDetailInitial());

  Future<void> getSpaceDetails(String id) async {
    emit(SpaceDetailLoading());
    try {
      final response = await _repository.getSpaceDetails(id);
      if (isClosed) return;
      if (response.isSuccess && response.data is SpaceModel) {
        emit(SpaceDetailSuccess(response.data as SpaceModel));
      } else {
        emit(SpaceDetailFailure(
            response.message ?? 'Failed to load space details'));
      }
    } catch (e) {
      if (!isClosed) emit(SpaceDetailFailure(e.toString()));
    }
  }
}
