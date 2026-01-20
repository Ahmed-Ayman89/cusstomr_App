import 'package:flutter_application_1/feature/spaces/data/models/space_model.dart';

abstract class SpaceState {}

class SpaceInitial extends SpaceState {}

class SpaceLoading extends SpaceState {}

class SpaceLoaded extends SpaceState {
  final List<SpaceModel> spaces;

  SpaceLoaded(this.spaces);
}

class SpaceDetailLoaded extends SpaceState {
  final SpaceModel space;

  SpaceDetailLoaded(this.space);
}

class SpaceError extends SpaceState {
  final String message;

  SpaceError(this.message);
}

class SpaceOperationSuccess extends SpaceState {
  final String message;

  SpaceOperationSuccess(this.message);
}
