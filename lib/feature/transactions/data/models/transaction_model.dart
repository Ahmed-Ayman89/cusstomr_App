class TransactionsResponseModel {
  final String total;
  final List<TransactionModel> transactions;

  TransactionsResponseModel({
    required this.total,
    required this.transactions,
  });

  factory TransactionsResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionsResponseModel(
      total: json['total']?.toString() ?? '0',
      transactions: (json['transactions'] as List?)
              ?.map((e) => TransactionModel.fromJson(e['transaction']))
              .toList() ??
          [],
    );
  }
}

class TransactionModel {
  final String amount;
  final String createdAt;
  final String type;
  final String? toSpace;
  final String? kiosk;

  TransactionModel({
    required this.amount,
    required this.createdAt,
    required this.type,
    this.toSpace,
    this.kiosk,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json['amount']?.toString() ?? '0',
      createdAt: json['created_at'] ?? '',
      type: json['type'] ?? '',
      toSpace: json['to_space'],
      kiosk: json['kiosk'],
    );
  }
}
