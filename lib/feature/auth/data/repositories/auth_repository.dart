import 'package:flutter_application_1/core/network/api_endpoiont.dart';
import 'package:flutter_application_1/core/network/api_helper.dart';
import 'package:flutter_application_1/core/network/api_response.dart';
import 'package:flutter_application_1/feature/auth/data/models/register_init_model.dart';
import 'package:flutter_application_1/core/network/local_data.dart';

class AuthRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> registerInit(RegisterInitModel model) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.customerRegisterInit,
        data: model.toJson(),
        isAuthorized: false,
        isFormData: false,
      );

      if (response.isSuccess && response.data != null) {
        // Check for tempToken in response data
        if (response.data is Map<String, dynamic>) {
          final data = response.data['data'];
          if (data != null && data is Map<String, dynamic>) {
            final tempToken = data['tempToken'];
            if (tempToken != null) {
              await LocalData.saveRegistrationToken(tempToken);
            }
          }
        }
      }

      return response;
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  Future<ApiResponse> verifyOtp(String code) async {
    try {
      final tempToken = await LocalData.getRegistrationToken();
      if (tempToken == null) {
        return ApiResponse.error(message: "Registration session expired");
      }

      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.customerVerifyOtp,
        data: {'code': code},
        isAuthorized: false,
        extraHeaders: {'Authorization': 'Bearer $tempToken'},
        isFormData: false,
      );

      if (response.isSuccess && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data['data'];
          if (data != null && data is Map<String, dynamic>) {
            // Assuming standard token response structure, similar to refresh
            final preAuthToken = data['preAuthToken'];
            if (preAuthToken != null) {
              await LocalData.savePreAuthToken(preAuthToken);
            }
            // Also save user data if present
            if (data['user'] != null) {
              final user = data['user'];
              await LocalData.saveUserData(
                userId: user['_id'] ?? '',
                userName: user['full_name'] ?? '',
                userEmail: '', // Email might not be in this response
                userRole: user['role'] ?? 'CUSTOMER',
              );
            }
          }
        }
      }

      return response;
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  Future<ApiResponse> registerComplete(String passcode) async {
    try {
      final preAuthToken = await LocalData.getPreAuthToken();
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.customerRegisterComplete,
        data: {'passcode': passcode},
        isAuthorized: false, // Manually handling auth
        extraHeaders: preAuthToken != null
            ? {'Authorization': 'Bearer $preAuthToken'}
            : null,
        isFormData: false,
      );

      // If response updates user data or tokens, handle it here
      // For now assuming existing tokens are valid or updated via interceptors if needed
      if (response.isSuccess) {
        await LocalData.savePasscode(passcode);
      }

      return response;
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  Future<ApiResponse> loginInit(String phone) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.customerLoginInit,
        data: {'phone': phone},
        isAuthorized: false,
        isFormData: false,
      );

      if (response.isSuccess && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data['data'];
          if (data != null && data is Map<String, dynamic>) {
            final tempToken = data['tempToken'];
            if (tempToken != null) {
              await LocalData.saveRegistrationToken(tempToken);
            }
          }
        }
      }

      return response;
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  Future<ApiResponse> loginComplete(String passcode) async {
    try {
      final preAuthToken = await LocalData.getPreAuthToken();
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.customerLoginComplete,
        data: {'passcode': passcode},
        isAuthorized: false, // Manually handling auth
        extraHeaders: preAuthToken != null
            ? {'Authorization': 'Bearer $preAuthToken'}
            : null,
        isFormData: false,
      );

      if (response.isSuccess && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data['data'];
          if (data != null && data is Map<String, dynamic>) {
            // Check for 'token' or 'accessToken'
            final accessToken = data['accessToken'] ?? data['token'];
            final refreshToken = data['refreshToken'];

            if (accessToken != null) {
              await LocalData.saveTokens(
                  accessToken: accessToken, refreshToken: refreshToken);
            }

            // Save User Data
            if (data['user'] != null) {
              final user = data['user'];
              await LocalData.saveUserData(
                userId: user['id'] ?? user['_id'] ?? '',
                userName: user['full_name'] ?? '',
                userEmail: '',
                userRole: user['role'] ?? 'CUSTOMER',
              );
            }
          }
        }
      }

      return response;
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  Future<ApiResponse> changePasscode(String passcode) async {
    try {
      final preAuthToken = await LocalData.getPreAuthToken();
      final response = await _apiHelper.postRequest(
        endPoint: EndPoints.customerChangePasscode,
        data: {'passcode': passcode},
        isAuthorized: false,
        extraHeaders: preAuthToken != null
            ? {'Authorization': 'Bearer $preAuthToken'}
            : null,
        isFormData: false,
      );

      // Same success handling as logic/register complete
      if (response.isSuccess) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data['data'];
          if (data != null && data is Map<String, dynamic>) {
            final accessToken = data['accessToken'] ?? data['token'];
            final refreshToken = data['refreshToken'];

            if (accessToken != null) {
              await LocalData.saveTokens(
                  accessToken: accessToken, refreshToken: refreshToken);
            }

            if (data['user'] != null) {
              final user = data['user'];
              await LocalData.saveUserData(
                userId: user['id'] ?? user['_id'] ?? '',
                userName: user['full_name'] ?? '',
                userEmail: '',
                userRole: user['role'] ?? 'CUSTOMER',
              );
            }
          }
          await LocalData.savePasscode(passcode);
        }
      }

      return response;
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }
}
