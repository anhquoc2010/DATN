import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/message.model.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/data/models/thread.model.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/chat.repository.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/data/repositories/user.repository.dart';

part 'chat.event.dart';
part 'chat.state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  final OrganizationRepository _organizationRepository;

  ChatBloc({
    required ChatRepository chatRepository,
    required UserRepository userRepository,
    required OrganizationRepository organizationRepository,
  })  : _chatRepository = chatRepository,
        _userRepository = userRepository,
        _organizationRepository = organizationRepository,
        super(const ChatState(status: HandleStatus.initial)) {
    on<ChatFetch>(_onChatFetch);
    on<ChatSubmit>(_onChatSubmit);
    on<ChatThreadFetch>(_onChatThreadFetch);
  }

  Future<void> _onChatThreadFetch(
    ChatThreadFetch event,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatState(status: HandleStatus.loading));

    var threads = event.organizationId != null
        ? await _chatRepository.fetchOrganizationThread(
            organizationId: event.organizationId!,
          )
        : await _chatRepository.fetchUserThread(
            userId: event.userId!,
          );
    threads = threads.reversed.toList();

    var users = <UserModel>[];
    var organizations = <OrganizationModel>[];
    for (final thread in threads) {
      if (event.organizationId == null) {
        final organization =
            await _organizationRepository.getOrganizationInfoById(
          thread.organizationId ?? 0,
        );
        organizations.add(organization);
      } else {
        final user = await _userRepository.getUserById(thread.userId ?? 0);
        users.add(user);
      }
    }

    emit(
      ChatState(
        threads: threads,
        users: users,
        organizations: organizations,
        status: HandleStatus.success,
      ),
    );
  }

  Future<void> _onChatFetch(ChatFetch event, Emitter<ChatState> emit) async {
    emit(const ChatState(status: HandleStatus.loading));

    final messages = await _chatRepository.fetchMessages(
      userId: event.userId,
      organizationId: event.organizationId,
    );

    emit(ChatState(messages: messages, status: HandleStatus.success));
  }

  Future<void> _onChatSubmit(ChatSubmit event, Emitter<ChatState> emit) async {
    emit(const ChatState(status: HandleStatus.loading));

    await _chatRepository.sendMessage(
      event.message,
      userId: event.userId,
      organizationId: event.organizationId,
      isUser: event.isUser,
    );

    emit(const ChatState(status: HandleStatus.success));

    add(
      ChatFetch(
        userId: event.userId,
        organizationId: event.organizationId,
      ),
    );
  }
}
