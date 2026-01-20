import '../data/models/support_model.dart';

abstract class SupportState {}

class SupportInitial extends SupportState {}

class SupportLoading extends SupportState {}

class SupportLoaded extends SupportState {
  final SupportData data;
  SupportLoaded(this.data);
}

class SupportError extends SupportState {
  final String message;
  SupportError(this.message);
}
