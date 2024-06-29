import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/common/widgets/avatar_info_card.widget.dart';
import 'package:mobile/common/widgets/common_error.widget.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/datasources/notification.mock.dart';
import 'package:mobile/data/models/message.model.dart';
import 'package:mobile/data/models/thread.model.dart';
import 'package:mobile/data/repositories/chat.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/campaign/widgets/management/campaign_get_common_error.widget.dart';
import 'package:mobile/modules/campaign/widgets/management/list_campaigns.widget.dart';
import 'package:mobile/modules/chat/chat.dart';
import 'package:mobile/modules/notification/notification.dart';
import 'package:mobile/modules/notification/widgets/list_noti.widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    super.key,
    // required this.initIndex,
  });

  // final int initIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(
        chatRepository: getIt.get<ChatRepository>(),
      )..add(
          context.read<AuthBloc>().state.status.isAuthenticatedOrganization
              ? ChatThreadFetch(
                  organizationId:
                      context.read<AuthBloc>().state.currentOrganizationId,
                  userId: null,
                )
              : ChatThreadFetch(
                  organizationId: null,
                  userId: context.read<AuthBloc>().state.user?.id,
                ),
        ),
      child: BlocListener<ChatBloc, ChatState>(
        listener: _onListener,
        child: const _NotificationView(
            // initIndex: initIndex,
            ),
      ),
    );
  }

  void _onListener(
    BuildContext context,
    ChatState state,
  ) {}
}

class _NotificationView extends StatefulWidget {
  const _NotificationView(
      // required this.initIndex,
      );

  // final int initIndex;

  @override
  State<_NotificationView> createState() => __NotificationView();
}

class __NotificationView extends State<_NotificationView>
    with TickerProviderStateMixin {
  // late TabController _tabController;

  // final List<dynamic> listAllNotis = NotificationMock.listAllNotis;
  // final List<dynamic> listUnreadNotis = NotificationMock.listUnreadNotis;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(
    //   // initialIndex: widget.initIndex,
    //   length: 2,
    //   vsync: this,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.texts_chat.tr()),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ChatBloc>().add(
                context
                        .read<AuthBloc>()
                        .state
                        .status
                        .isAuthenticatedOrganization
                    ? ChatThreadFetch(
                        organizationId: context
                            .read<AuthBloc>()
                            .state
                            .currentOrganizationId,
                        userId: null,
                      )
                    : ChatThreadFetch(
                        organizationId: null,
                        userId: context.read<AuthBloc>().state.user?.id,
                      ),
              );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return ConditionalRenderUtil.single(
                context,
                value: state.status,
                caseBuilders: {
                  HandleStatus.loading: (_) => const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                  HandleStatus.error: (_) => Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppSize.horizontalSpace),
                          child: CommonError(
                            title: LocaleKeys.texts_error_occur.tr(),
                          ),
                        ),
                      ),
                  HandleStatus.initial: (_) => const SizedBox.shrink(),
                },
                fallbackBuilder: (_) {
                  if (state.threads.isEmpty) {
                    return Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppSize.horizontalSpace),
                          child: CommonError(
                            title: LocaleKeys.texts_error_occur.tr(),
                          ),
                        ),
                      );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(
                      AppSize.horizontalSpace,
                    ),
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) {
                      final ThreadModel currentThread = state.threads[index];
                      final List<MessageModel> messages = currentThread.messages ?? [];

                      return AvatarInfoCard(
                        description: messages.isNotEmpty
                            ? messages.first.message ?? ''
                            : '',
                        title: currentCampaign.name,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.campaignDetail,
                            arguments: currentCampaign,
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    shrinkWrap: true,
                    itemCount: campaigns.length,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
