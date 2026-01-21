import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/space_model.dart';
import '../data/repository/space_repository.dart';
import 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  final SpaceRepository _repository;

  TransferCubit(this._repository) : super(TransferInitial());

  // Internal state tracking
  int _currentStep = 0;
  SpaceModel? _sourceSpace;
  SpaceModel? _destinationSpace;
  double _amount = 0;

  void initialize({SpaceModel? initialSource, SpaceModel? initialDestination}) {
    _sourceSpace = initialSource;
    _destinationSpace = initialDestination;
    _currentStep = 0;
    _amount = 0;
    _emitState();
  }

  void selectSource(SpaceModel? space) {
    _sourceSpace = space;
    _emitState();
  }

  void selectDestination(SpaceModel? space) {
    _destinationSpace = space;
    _emitState();
  }

  void setAmount(double amount) {
    _amount = amount;
    _emitState();
  }

  void nextStep() {
    if (_currentStep == 0) {
      if (_destinationSpace == null) {
        emit(TransferError("Please select a destination space"));
        _emitState(); // Re-emit current state to clear error visually if handled
        return;
      }
      // Simple validation: cannot transfer to same space
      if (_sourceSpace?.id == _destinationSpace?.id && _sourceSpace != null) {
        emit(TransferError("Cannot transfer to the same space"));
        _emitState();
        return;
      }
    } else if (_currentStep == 1) {
      if (_amount <= 0) {
        emit(TransferError("Please enter a valid amount"));
        _emitState();
        return;
      }
      // Validate balance if source is a space
      if (_sourceSpace != null) {
        if (_sourceSpace!.currentAmount < _amount) {
          emit(TransferError("Insufficient balance in source space"));
          _emitState();
          return;
        }
      }
    }

    _currentStep++;
    _emitState();
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      _emitState();
    }
  }

  Future<void> confirmTransfer(String passcode) async {
    // In a real app, validate passcode with auth repo
    // For now, assume valid if length is 6 (handled by UI mostly)

    emit(TransferLoading());
    try {
      await _repository.transferPoints(
        _sourceSpace?.id, // null means Main Account
        _destinationSpace
            ?.id, // null means Main Account (but usually we pick a space)
        _amount,
      );
      emit(TransferSuccess("Transfer Successful"));
    } catch (e) {
      emit(TransferError(e.toString()));
      // Revert to passcode step or stay?
      // Usually stay on passcode or go back.
      // Let's reset to passcode step so user can try again or see error
      _emitState();
    }
  }

  void _emitState() {
    emit(TransferStepChanged(
      step: _currentStep,
      sourceSpace: _sourceSpace,
      destinationSpace: _destinationSpace,
      amount: _amount,
    ));
  }
}
