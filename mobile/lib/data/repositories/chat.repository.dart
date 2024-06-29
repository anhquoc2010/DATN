import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/remote/chat.datasource.dart';
import 'package:mobile/data/models/message.model.dart';
import 'package:mobile/data/models/thread.model.dart';

@lazySingleton
class ChatRepository {
  final ChatDataSource _dataSource;
  ChatRepository({
    required ChatDataSource dataSource,
  }) : _dataSource = dataSource;

  Future<void> sendMessage(
    String question, {
    required int userId,
    required int organizationId,
    required bool isUser,
  }) {
    return _dataSource.sendMessage(
      question,
      userId: userId,
      organizationId: organizationId,
      isUser: isUser,
    );
  }

  Future<List<MessageModel>> fetchMessages({
    required int userId,
    required int organizationId,
  }) {
    return _dataSource.fetchMessages(
      userId: userId,
      organizationId: organizationId,
    );
  }

  Future<List<ThreadModel>> fetchOrganizationThread({
    required int organizationId,
  }) {
    return _dataSource.fetchOrganizationThread(
      organizationId: organizationId,
    );
  }

  Future<List<ThreadModel>> fetchUserThread({
    required int userId,
  }) {
    return _dataSource.fetchUserThread(
      userId: userId,
    );
  }
}
