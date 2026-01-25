import 'package:flutter_application_1/feature/transactions/data/models/transaction_model.dart';

class DashboardModel {
  final String balance;
  final String?
      activeGoal; // Keeping it simple for now as it's null in response
  final List<TransactionModel> recentTransactions;

  DashboardModel({
    required this.balance,
    this.activeGoal,
    required this.recentTransactions,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      balance: json['balance']?.toString() ?? '0.00',
      activeGoal:
          json['active_goal'], // Can parse this further if structure known
      recentTransactions: (json['recent_transactions'] as List?)
              ?.map((e) => TransactionModel.fromJson(e['transaction']))
              .toList() ??
          [],
    );
  }
}
