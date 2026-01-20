class SpaceModel {
  final String id;
  final String name;
  final String iconAsset;
  final double currentAmount;
  final double? goalAmount;
  final String color;
  final bool hasGoal;
  final DateTime? deadline;

  SpaceModel({
    required this.id,
    required this.name,
    required this.iconAsset,
    required this.currentAmount,
    this.goalAmount,
    required this.color,
    required this.hasGoal,
    this.deadline,
  });

  double get progress {
    if (goalAmount == null || goalAmount == 0) return 0;
    return (currentAmount / goalAmount!).clamp(0.0, 1.0);
  }

  bool get isGoalCompleted =>
      hasGoal && goalAmount != null && currentAmount >= goalAmount!;

  factory SpaceModel.fromJson(Map<String, dynamic> json) {
    return SpaceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      iconAsset: json['iconAsset'] ?? '',
      currentAmount: (json['currentAmount'] ?? 0).toDouble(),
      goalAmount: json['goalAmount'] != null
          ? (json['goalAmount'] as num).toDouble()
          : null,
      color: json['color'] ?? '#008751',
      hasGoal: json['hasGoal'] ?? false,
      deadline:
          json['deadline'] != null ? DateTime.tryParse(json['deadline']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconAsset': iconAsset,
      'currentAmount': currentAmount,
      'goalAmount': goalAmount,
      'color': color,
      'hasGoal': hasGoal,
      'deadline': deadline?.toIso8601String(),
    };
  }

  SpaceModel copyWith({
    String? id,
    String? name,
    String? iconAsset,
    double? currentAmount,
    double? goalAmount,
    String? color,
    bool? hasGoal,
    DateTime? deadline,
  }) {
    return SpaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      iconAsset: iconAsset ?? this.iconAsset,
      currentAmount: currentAmount ?? this.currentAmount,
      goalAmount: goalAmount ?? this.goalAmount,
      color: color ?? this.color,
      hasGoal: hasGoal ?? this.hasGoal,
      deadline: deadline ?? this.deadline,
    );
  }
}
