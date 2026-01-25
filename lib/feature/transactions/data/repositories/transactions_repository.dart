import 'package:flutter_application_1/core/network/api_endpoiont.dart';
import 'package:flutter_application_1/core/network/api_helper.dart';
import 'package:flutter_application_1/core/network/api_response.dart';
import 'package:flutter_application_1/feature/transactions/data/models/transaction_model.dart';

class TransactionsRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> getTransactions() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.customerTransactions,
        isProtected: true,
      );

      if (response.isSuccess && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data['data'];
          if (data != null) {
            final transactionsData = TransactionsResponseModel.fromJson(data);
            // Return success with parsed model
            return ApiResponse.success(
                data: transactionsData,
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
