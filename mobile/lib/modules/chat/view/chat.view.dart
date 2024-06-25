import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/modules/chat/chat.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(),
      child: const _ChatView(),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView();

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final ChatUser _user = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );

  late final List<ChatMessage> _messages = <ChatMessage>[
    ChatMessage(
      text: 'Hey!',
      user: _user,
      createdAt: DateTime.now(),
    ),
  ];

  List<Mention> _mentions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Chat',
      ),
      body: DashChat(
        currentUser: _user,
        inputOptions: InputOptions(
          onMention: (
            String trigger,
            String value,
            void Function(String) onMentionClick,
          ) {
            // Here you would typically do a request to your backend
            // to get the correct results to show
            // according to the trigger and value
            return Future.delayed(
              const Duration(milliseconds: 500),
              () {
                return <Widget>[
                  ListTile(
                    leading: DefaultAvatar(user: _user),
                    title: Text(_user.getFullName()),
                    onTap: () {
                      onMentionClick(_user.getFullName());
                      _mentions.add(
                        Mention(
                          title: trigger + _user.getFullName(),
                          customProperties: <String, dynamic>{
                            'userId': _user.id,
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: DefaultAvatar(user: _user),
                    title: Text(_user.getFullName()),
                    onTap: () {
                      onMentionClick(_user.getFullName());
                      _mentions.add(
                        Mention(
                          title: trigger + _user.getFullName(),
                          customProperties: <String, dynamic>{
                            'userId': _user.id,
                          },
                        ),
                      );
                    },
                  ),
                ];
              },
            );
          },
          onMentionTriggers: ['@', '#'],
          inputTextStyle: const TextStyle(
            color: Color(0xff001eff),
          ),
          inputDecoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: const Color(0xff00b8ff),
            contentPadding: const EdgeInsets.only(
              left: 18,
              top: 10,
              bottom: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        ),
        messageOptions: MessageOptions(
          onPressMention: (mention) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(mention.title),
                  content: Text(mention.customProperties.toString()),
                );
              },
            );
          },
          containerColor: const Color(0xffd600ff),
          currentUserContainerColor: const Color(0xffbd00ff),
          currentUserTextColor: const Color(0xfffbf665),
          currentUserTimeTextColor: const Color.fromRGBO(73, 0, 100, 1),
          messagePadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          showTime: true,
          spaceWhenAvatarIsHidden: 6,
          textColor: const Color(0xfffbf665),
          timeFontSize: 8,
          timePadding: const EdgeInsets.only(top: 2),
          timeTextColor: const Color.fromRGBO(73, 0, 100, 1),
        ),
        messageListOptions: MessageListOptions(
          dateSeparatorBuilder: (date) => DefaultDateSeparator(
            date: date,
            textStyle: const TextStyle(
              color: Color(0xff00ff9f),
              fontWeight: FontWeight.bold,
            ),
          ),
          onLoadEarlier: () async {
            await Future.delayed(const Duration(seconds: 3));
          },
        ),
        onSend: (ChatMessage m) {
          m.mentions = _mentions;
          setState(() {
            _messages.insert(0, m);
            _mentions = [];
          });
        },
        messages: _messages,
      ),
    );
  }
}
