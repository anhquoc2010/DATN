import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio/dio.helper.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserDataSource {
  Future<void> loginByEmail(AuthenticationDTO params) async {
    await DioHelper.post(
      Endpoints.login,
      data: params.toJson(),
    );
  }
}
