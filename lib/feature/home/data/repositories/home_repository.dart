import 'package:flutter_application_1/core/network/api_endpoiont.dart';
import 'package:flutter_application_1/core/network/api_helper.dart';
import 'package:flutter_application_1/core/network/api_response.dart';
import 'package:flutter_application_1/feature/home/data/models/dashboard_model.dart';

class HomeRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> getDashboardData() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.customerDashboard,
        isProtected: true,
      );

      if (response.isSuccess && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data['data'];
          if (data != null) {
            final dashboardData = DashboardModel.fromJson(data);
            return ApiResponse.success(
                data: dashboardData,
                message: response.message,
                statusCode: response.statusCode);
          }
        }
      }

      return response;
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }
}
