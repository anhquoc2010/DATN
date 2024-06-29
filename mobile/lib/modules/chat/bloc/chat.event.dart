part of 'chat.bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatFetch extends ChatEvent {
  const ChatFetch({required this.organizationId, required this.userId});

  final int organizationId;
  final int userId;

  @override
  List<Object?> get props => [organizationId, userId];
}

class ChatSubmit extends ChatEvent {
  const ChatSubmit({
    required this.organizationId,
    required this.userId,
    required this.message,
    required this.isUser,
  });

  final int organizationId;
  final int userId;
  final String message;
  final bool isUser;

  @override
  List<Object?> get props => [organizationId, userId, message, isUser];
}

class ChatThreadFetch extends ChatEvent {
  const ChatThreadFetch({required this.organizationId, required this.userId});

  final int? organizationId;
  final int? userId;

  @override
  List<Object?> get props => [organizationId, userId];
}
