import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/bloc/management/campaign_management.bloc.dart';
import 'package:mobile/modules/campaign/widgets/management/add_campaign_fab.widget.dart';
import 'package:mobile/modules/campaign/widgets/management/campaign_get_common_error.widget.dart';
import 'package:mobile/modules/campaign/widgets/management/list_campaigns.widget.dart';

class CampaignManagementPage extends StatelessWidget {
  const CampaignManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CampaignManagementView();
  }
}

class _CampaignManagementView extends StatelessWidget {
  const _CampaignManagementView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.campaign_management.tr()),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CampaignManagementBloc>().add(
                const CampaignManagementGet(),
              );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          child: BlocBuilder<CampaignManagementBloc, CampaignManagementState>(
            builder: (context, state) {
              return ConditionalRenderUtil.single(
                context,
                value: state.status,
                caseBuilders: {
                  HandleStatus.loading: (_) => const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                  HandleStatus.error: (_) =>
                      const Center(child: CampaignGetCommonError()),
                  HandleStatus.initial: (_) => const SizedBox.shrink(),
                },
                fallbackBuilder: (_) {
                  if (state.campaigns.isEmpty) {
                    return Center(
                      child: CampaignGetCommonError(
                        isEmpty: state.campaigns.isEmpty,
                      ),
                    );
                  }

                  return ListCampaigns(campaigns: state.campaigns);
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight + 5),
        child: AddCampaignFAB(),
      ),
    );
  }
}
