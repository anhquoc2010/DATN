import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio.helper.dart';
import 'package:mobile/data/models/message.model.dart';
import 'package:mobile/data/models/thread.model.dart';

@lazySingleton
class ChatDataSource {
  final DioHelper _dioHelper;

  const ChatDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  Future<void> sendMessage(
    String question, {
    required int userId,
    required int organizationId,
    required bool isUser,
  }) async {
    await _dioHelper.post(
      '${Endpoints.chat}/?organization_id=$organizationId&user_id=$userId&is_user=$isUser&question=$question',
    );
  }

  Future<List<MessageModel>> fetchMessages({
    required int userId,
    required int organizationId,
  }) async {
    final response = await _dioHelper.get(
      '${Endpoints.thread}/search/?organization_id=$organizationId&user_id=$userId',
    );

    final data = response.body as List;
    //check if the data is not empty
    if (data.isEmpty) {
      return [];
    } else {
      final messages = data[0]['messages'] as List;
      return messages.map((e) => MessageModel.fromJson(e)).toList();
    }
  }

  Future<List<ThreadModel>> fetchOrganizationThread({
    required int organizationId,
  }) async {
    final response = await _dioHelper.get(
      '${Endpoints.thread}/search/?organization_id=$organizationId',
    );

    final data = response.body as List;
    return data.map((e) => ThreadModel.fromJson(e)).toList();
  }

  Future<List<ThreadModel>> fetchUserThread({
    required int userId,
  }) async {
    final response = await _dioHelper.get(
      '${Endpoints.thread}/search/?user_id=$userId',
    );

    final data = response.body as List;
    return data.map((e) => ThreadModel.fromJson(e)).toList();
  }
}
