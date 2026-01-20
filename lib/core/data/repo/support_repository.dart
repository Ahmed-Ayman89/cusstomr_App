import 'package:flutter_application_1/core/network/api_endpoiont.dart';
import 'package:flutter_application_1/core/network/api_helper.dart';
import '../models/support_model.dart';

abstract class SupportRepository {
  Future<SupportResponse> getSupportInfo();
}

class SupportRepositoryImpl implements SupportRepository {
  @override
  Future<SupportResponse> getSupportInfo() async {
    try {
      final response = await APIHelper().getRequest(
        endPoint: EndPoints.support,
        isProtected: true,
      );

      if (response.isSuccess && response.data != null) {
        return SupportResponse.fromJson(response.data);
      } else {
        throw response.message ?? 'Unknown error';
      }
    } catch (e) {
      rethrow;
    }
  }
}
