part of 'chat.bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.threads = const [],
    this.messages = const [],
    this.users = const [],
    this.organizations = const [],
    required this.status,
  });

  final List<ThreadModel> threads;
  final List<MessageModel> messages;
  final HandleStatus status;
  final List<UserModel> users;
  final List<OrganizationModel> organizations;

  @override
  List<Object> get props => [messages, status, threads, users, organizations];
}
