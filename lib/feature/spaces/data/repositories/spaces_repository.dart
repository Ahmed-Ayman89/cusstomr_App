import 'package:flutter_application_1/core/network/api_endpoiont.dart';
import 'package:flutter_application_1/core/network/api_helper.dart';
import 'package:flutter_application_1/core/network/api_response.dart';
import 'package:flutter_application_1/feature/spaces/data/models/space_model.dart';

class SpacesRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> getSpaces() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.customerSpaces,
        isProtected: true,
      );

      if (response.isSuccess && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          // Response structure: { success: true, data: { balance: "...", spaces: [...] } }
          final data = response.data['data'];
          if (data != null && data is Map<String, dynamic>) {
            final spacesData = SpacesResponseModel.fromJson(data);
            return ApiResponse.success(
                data: spacesData,
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

  Future<ApiResponse> getSpaceDetails(String id) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.customerSpaces}/$id',
        isProtected: true,
      );

      if (response.isSuccess && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          // Response: { success: true, data: { id:..., transactions:[...] } }
          final data = response.data['data'];
          if (data != null && data is Map<String, dynamic>) {
            final space = SpaceModel.fromJson(data);
            return ApiResponse.success(
                data: space,
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

  Future<ApiResponse> createSpace({
    required String name,
    required String? image,
    required double targetAmount,
    required String deadline,
    required String passcode,
  }) async {
    try {
      final data = {
        "name": name,
        "image": image,
        "target_amount": targetAmount,
        "deadline": deadline,
        "passcode": passcode,
      };

      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.customerSpaces,
        data: data,
        isAuthorized: true,
        isFormData: false,
      );

      if (response.isSuccess) {
        // Optionally parse the created space if the API returns it,
        // but usually we just need to know it succeeded and then refresh the list.
        return ApiResponse.success(
            data:
                response.data, // Pass through whatever data came back, or null
            message: response.message ?? 'Space created successfully',
            statusCode: response.statusCode);
      }
      return response;
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }
}
