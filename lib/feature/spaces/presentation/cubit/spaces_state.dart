part of 'spaces_cubit.dart';

abstract class SpacesState {}

class SpacesInitial extends SpacesState {}

class SpacesLoading extends SpacesState {}

class SpacesSuccess extends SpacesState {
  final SpacesResponseModel data;
  SpacesSuccess(this.data);
}

class SpacesFailure extends SpacesState {
  final String message;
  SpacesFailure(this.message);
}
