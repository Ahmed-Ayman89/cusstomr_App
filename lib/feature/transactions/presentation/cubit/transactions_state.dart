part of 'transactions_cubit.dart';

abstract class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsSuccess extends TransactionsState {
  final TransactionsResponseModel data;
  TransactionsSuccess(this.data);
}

class TransactionsFailure extends TransactionsState {
  final String message;
  TransactionsFailure(this.message);
}
