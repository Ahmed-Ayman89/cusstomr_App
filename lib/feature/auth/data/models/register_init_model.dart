class RegisterInitModel {
  final String fullName;
  final String phone;

  RegisterInitModel({
    required this.fullName,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phone': phone,
    };
  }
}
