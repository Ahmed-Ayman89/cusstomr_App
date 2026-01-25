class NotificationsResponseModel {
  final List<NotificationModel> notifications;

  NotificationsResponseModel({required this.notifications});

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationsResponseModel(
      notifications: (json['data'] as List?)
              ?.map((e) => NotificationModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class NotificationModel {
  final String title;
  final String body;
  final String timestamp;

  NotificationModel({
    required this.title,
    required this.body,
    required this.timestamp,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}
