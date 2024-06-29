part of 'chat.bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.threads = const [],
    this.messages = const [],
    required this.status,
  });

  final List<ThreadModel> threads;
  final List<MessageModel> messages;
  final HandleStatus status;

  @override
  List<Object> get props => [messages, status];
}
