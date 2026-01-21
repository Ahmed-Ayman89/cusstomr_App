import '../data/models/space_model.dart';

abstract class TransferState {}

class TransferInitial extends TransferState {}

class TransferLoading extends TransferState {}

class TransferSuccess extends TransferState {
  final String message;
  TransferSuccess(this.message);
}

class TransferError extends TransferState {
  final String message;
  TransferError(this.message);
}

class TransferStepChanged extends TransferState {
  final int step; // 0: Select, 1: Amount, 2: Passcode
  final SpaceModel? sourceSpace;
  final SpaceModel? destinationSpace;
  final double amount;

  TransferStepChanged({
    required this.step,
    this.sourceSpace,
    this.destinationSpace,
    this.amount = 0,
  });

  TransferStepChanged copyWith({
    int? step,
    SpaceModel? sourceSpace,
    SpaceModel? destinationSpace,
    double? amount,
  }) {
    return TransferStepChanged(
      step: step ?? this.step,
      sourceSpace: sourceSpace ?? this.sourceSpace,
      destinationSpace: destinationSpace ?? this.destinationSpace,
      amount: amount ?? this.amount,
    );
  }
}
