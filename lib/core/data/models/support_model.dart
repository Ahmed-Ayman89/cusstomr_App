class SupportResponse {
  final bool? success;
  final String? message;
  final String? timestamp;
  final SupportData? data;

  SupportResponse({
    this.success,
    this.message,
    this.timestamp,
    this.data,
  });

  factory SupportResponse.fromJson(Map<String, dynamic> json) {
    return SupportResponse(
      success: json['success'],
      message: json['message'],
      timestamp: json['timestamp'],
      data: json['data'] != null ? SupportData.fromJson(json['data']) : null,
    );
  }
}

class SupportData {
  final String? whatsapp;
  final String? facebook;

  SupportData({
    this.whatsapp,
    this.facebook,
  });

  factory SupportData.fromJson(Map<String, dynamic> json) {
    return SupportData(
      whatsapp: json['whatsapp'],
      facebook: json['facebook'],
    );
  }
}
