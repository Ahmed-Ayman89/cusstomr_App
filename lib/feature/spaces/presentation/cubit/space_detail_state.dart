part of 'space_detail_cubit.dart';

abstract class SpaceDetailState {}

class SpaceDetailInitial extends SpaceDetailState {}

class SpaceDetailLoading extends SpaceDetailState {}

class SpaceDetailSuccess extends SpaceDetailState {
  final SpaceModel space;
  SpaceDetailSuccess(this.space);
}

class SpaceDetailFailure extends SpaceDetailState {
  final String message;
  SpaceDetailFailure(this.message);
}
