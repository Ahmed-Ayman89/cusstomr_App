class SpacesResponseModel {
  final String balance; // Global balance from the response
  final List<SpaceModel> spaces;

  SpacesResponseModel({required this.balance, required this.spaces});

  factory SpacesResponseModel.fromJson(Map<String, dynamic> json) {
    return SpacesResponseModel(
      balance: json['balance']?.toString() ?? '0.00',
      spaces: (json['spaces'] as List?)
              ?.map((e) => SpaceModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class SpaceModel {
  final String id;
  final String name;
  final String balance;

  // Details fields
  final String? targetAmount;
  final String? deadline;
  final List<SpaceTransactionModel>? transactions;

  // Local state fields
  final String? _iconAsset;
  final bool? _hasGoal;
  final double? _goalAmount;
  final DateTime? _deadline;

  SpaceModel({
    required this.id,
    required this.name,
    required this.balance,
    this.targetAmount,
    this.deadline,
    this.transactions,
    String? iconAsset,
    bool? hasGoal,
    double? goalAmount,
    DateTime? deadlineObj,
  })  : _iconAsset = iconAsset,
        _hasGoal = hasGoal,
        _goalAmount = goalAmount,
        _deadline = deadlineObj;

  factory SpaceModel.fromJson(Map<String, dynamic> json) {
    return SpaceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      balance: json['balance']?.toString() ?? '0.00',
      targetAmount: json['target_amount']?.toString(),
      deadline: json['deadline'],
      transactions: (json['transactions'] as List?)
          ?.map((e) => SpaceTransactionModel.fromJson(e))
          .toList(),
    );
  }

  // Backward compatibility getters
  double get currentAmount => double.tryParse(balance) ?? 0.0;
  String get iconAsset => _iconAsset ?? 'assets/icons/spaces.svg';
  // Use local hasGoal/goalAmount if set (optimistic UI), otherwise infer from targetAmount
  bool get hasGoal => _hasGoal ?? (targetAmount != null);
  double? get goalAmount =>
      _goalAmount ??
      (targetAmount != null ? double.tryParse(targetAmount!) : null);
  // Parse API deadline string to DateTime if available
  DateTime? get deadlineObj {
    if (_deadline != null) return _deadline;
    if (deadline != null) {
      try {
        return DateTime.parse(deadline!);
      } catch (_) {}
    }
    return null;
  }

  double get progress {
    final goal = goalAmount;
    if (goal == null || goal == 0) return 0.0;
    return (currentAmount / goal).clamp(0.0, 1.0);
  }

  SpaceModel copyWith({
    String? id,
    String? name,
    String? balance,
    String? targetAmount,
    String? deadline,
    List<SpaceTransactionModel>? transactions,
    String? iconAsset,
    bool? hasGoal,
    double? goalAmount,
    DateTime? deadlineObj,
  }) {
    return SpaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      targetAmount: targetAmount ?? this.targetAmount,
      deadline: deadline ?? this.deadline,
      transactions: transactions ?? this.transactions,
      iconAsset: iconAsset ?? this._iconAsset,
      hasGoal: hasGoal ?? this._hasGoal,
      goalAmount: goalAmount ?? this._goalAmount,
      deadlineObj: deadlineObj ?? this._deadline,
    );
  }
}

class SpaceTransactionModel {
  final String id;
  final String amount;
  final String? fromSpaceId;
  final String? fromSpaceName;
  final String? toSpaceId;
  final String? toSpaceName;
  // created_at wasn't in the snippet but usually exists, assuming it might be needed or we use current time if missing?
  // User snippet didn't show date, but UI has "Yesterday, 11:30 PM".
  // Actually, let's stick to what's in the JSON: id, amount, from etc.

  SpaceTransactionModel({
    required this.id,
    required this.amount,
    this.fromSpaceId,
    this.fromSpaceName,
    this.toSpaceId,
    this.toSpaceName,
  });

  factory SpaceTransactionModel.fromJson(Map<String, dynamic> json) {
    return SpaceTransactionModel(
      id: json['id'] ?? '',
      amount: json['amount']?.toString() ?? '0.00',
      fromSpaceId: json['from_space_id'],
      fromSpaceName: json['from_space_name'],
      toSpaceId: json['to_space_id'],
      toSpaceName: json['to_space_name'],
    );
  }
}
