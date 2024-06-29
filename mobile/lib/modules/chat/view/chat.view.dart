import 'dart:async';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/models/message.model.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/chat.repository.dart';
import 'package:mobile/data/repositories/organization.repository.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/chat/chat.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.organization,
    required this.user,
  });

  final OrganizationModel? organization;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(
        chatRepository: getIt.get<ChatRepository>(),
        userRepository: getIt.get<UserRepository>(),
        organizationRepository: getIt.get<OrganizationRepository>(),
      )..add(
          ChatFetch(
            userId: user?.id ?? 0,
            organizationId: organization?.id ?? 0,
          ),
        ),
      child: _ChatView(
        organization: organization,
        user: user,
      ),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({
    required this.organization,
    required this.user,
  });

  final OrganizationModel? organization;
  final UserModel? user;

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  late ChatUser currentUser;
  late ChatUser otherUser;
  Timer? _fetchTimer;
  List<MessageModel> _messages = [];
  late Widget chatWidget;

  @override
  void initState() {
    super.initState();
    currentUser =
        context.read<AuthBloc>().state.status.isAuthenticatedOrganization
            ? ChatUser(
                id: widget.organization?.id.toString() ?? '0',
                firstName: widget.organization?.name ?? '',
                profileImage: widget.organization?.avatar ?? '',
              )
            : ChatUser(
                id: widget.user?.id.toString() ?? '0',
                firstName: widget.user?.fullName ?? '',
                profileImage: widget.user?.avatar ?? '',
              );
    otherUser =
        context.read<AuthBloc>().state.status.isAuthenticatedOrganization
            ? ChatUser(
                id: widget.user?.id.toString() ?? '0',
                firstName: widget.user?.fullName ?? '',
                profileImage: widget.user?.avatar ?? '',
              )
            : ChatUser(
                id: widget.organization?.id.toString() ?? '0',
                firstName: widget.organization?.name ?? '',
                profileImage: widget.organization?.avatar ?? '',
              );

    chatWidget = buildChatWidget();
    _startFetchingMessages();
  }

  void _startFetchingMessages() {
    _fetchTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      context.read<ChatBloc>().add(
            ChatFetch(
              userId: widget.user?.id ?? 0,
              organizationId: widget.organization?.id ?? 0,
            ),
          );
    });
  }

  @override
  void dispose() {
    _fetchTimer?.cancel();
    super.dispose();
  }

  Widget buildChatWidget() {
    return DashChat(
      currentUser: currentUser,
      messageOptions: const MessageOptions(
        showCurrentUserAvatar: true,
        currentUserContainerColor: ColorStyles.primary2,
        currentUserTextColor: ColorStyles.zodiacBlue,
        messagePadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        showTime: true,
        spaceWhenAvatarIsHidden: 6,
        timeFontSize: 8,
        timePadding: EdgeInsets.only(top: 2),
      ),
      messageListOptions: MessageListOptions(
        dateSeparatorBuilder: (date) => DefaultDateSeparator(
          date: date,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onLoadEarlier: () async {
          await Future.delayed(const Duration(seconds: 3));
        },
      ),
      onSend: (ChatMessage m) {
        //add at 0
        setState(() {
          _messages.insert(
            0,
            MessageModel(
              message: m.text,
              isUser: context
                  .read<AuthBloc>()
                  .state
                  .status
                  .isAuthenticatedOrganization,
              createdAt: DateTime.now(),
            ),
          );
        });
        context.read<ChatBloc>().add(
              ChatSubmit(
                message: m.text,
                userId: widget.user?.id ?? 0,
                organizationId: widget.organization?.id ?? 0,
                isUser: !context
                    .read<AuthBloc>()
                    .state
                    .status
                    .isAuthenticatedOrganization,
              ),
            );
      },
      messages: _messages
          .map(
            (e) => ChatMessage(
              text: e.message ?? '',
              user: ChatUser(
                id: (e.isUser ?? false)
                    ? widget.user?.id.toString() ?? '0'
                    : widget.organization?.id.toString() ?? '0',
                firstName: (e.isUser ?? false)
                    ? widget.user?.fullName ?? ''
                    : widget.organization?.name ?? '',
              ),
              createdAt: e.createdAt ?? DateTime.now(),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.read<AuthBloc>().state.status.isAuthenticatedOrganization
            ? '${widget.user?.fullName}'
            : '${widget.organization?.name}',
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listenWhen: (previous, current) {
          // first time return true
          if (_messages.isEmpty) {
            return true;
          }

          if (current.status.isSuccess) {
            return _messages.length != current.messages.length;
          } else {
            return false;
          }
        },
        listener: (context, state) {
          setState(() {
            _messages = state.messages;
            chatWidget = buildChatWidget();
          });
        },
        child: chatWidget,
      ),
    );
  }
}
