import 'package:flutter_application_1/core/network/api_endpoiont.dart';
import 'package:flutter_application_1/core/network/api_helper.dart';
import 'package:flutter_application_1/core/network/api_response.dart';
import 'package:flutter_application_1/feature/notifications/data/models/notification_model.dart';

class NotificationsRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> getNotifications() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.customerNotifications,
        isProtected: true,
      );

      if (response.isSuccess && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          // The API returns { "data": [] } usually, but let's check structure
          // Based on previous logs, structure is { success, message, data: [] }
          // So passing the whole map to fromJson might be safer if fromJson extracts 'data'
          final notificationsData =
              NotificationsResponseModel.fromJson(response.data);
          return ApiResponse.success(
              data: notificationsData,
              message: response.message,
              statusCode: response.statusCode);
        }
      }

      return response;
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }
}
