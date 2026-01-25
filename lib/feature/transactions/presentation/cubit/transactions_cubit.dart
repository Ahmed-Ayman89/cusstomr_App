import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/feature/transactions/data/models/transaction_model.dart';
import 'package:flutter_application_1/feature/transactions/data/repositories/transactions_repository.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final TransactionsRepository _repository;

  TransactionsCubit({required TransactionsRepository repository})
      : _repository = repository,
        super(TransactionsInitial());

  Future<void> getTransactions() async {
    emit(TransactionsLoading());
    try {
      final response = await _repository.getTransactions();
      if (isClosed) return;
      if (response.isSuccess && response.data is TransactionsResponseModel) {
        emit(TransactionsSuccess(response.data as TransactionsResponseModel));
      } else {
        emit(TransactionsFailure(
            response.message ?? 'Failed to load transactions'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TransactionsFailure(e.toString()));
    }
  }
}
