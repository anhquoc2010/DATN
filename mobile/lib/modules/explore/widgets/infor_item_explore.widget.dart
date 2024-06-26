import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class InforItemExploreWidget extends StatelessWidget {
  const InforItemExploreWidget({
    super.key,
    required this.item,
  });
  final CampaignModel item;

  String get _campaignStatus {
    if (item.isUpcoming) {
      return LocaleKeys.profile_upcoming.tr();
    }
    if (item.isEnded) {
      return LocaleKeys.campaign_ended.tr();
    }
    return LocaleKeys.campaign_ongoing.tr();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // name
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: item.name,
                style: TextStyles.boldBody16.copyWith(
                  color: ColorStyles.zodiacBlue,
                ),
              ),
              TextSpan(
                text: ' - ',
                style: TextStyles.boldBody16.copyWith(
                  color: ColorStyles.zodiacBlue,
                ),
              ),
              TextSpan(
                text: _campaignStatus,
                style: TextStyles.boldBody16.copyWith(
                  color: item.isEnded
                      ? ColorStyles.alert
                      : item.isOngoing
                          ? ColorStyles.primary1
                          : Colors.amber,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 4,
          color: Colors.transparent,
        ),

        // address
        Text(
          item.fullAddress,
          style: TextStyles.regularBody14.copyWith(
            color: ColorStyles.zodiacBlue,
          ),
        ),
        const Divider(
          height: 16,
        ),

        // organization
        Row(
          children: [
            item.organization?.avatar != null && item.organization!.avatar!.isNotEmpty
                ? Image.network(
                    item.organization!.avatar!,
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  )
                : Assets.icons.icUserGroup.image(
                    height: 20,
                    width: 20,
                  ),
            const VerticalDivider(
              width: 8,
              color: Colors.transparent,
            ),
            Text(
              item.organization?.name ?? '',
              style: TextStyles.regularBody14.copyWith(
                color: ColorStyles.zodiacBlue,
              ),
            ),
          ],
        ),
        const Divider(
          height: 4,
          color: Colors.transparent,
        ),

        // description
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Assets.icons.icAnnotation.image(
              height: 20,
              width: 20,
            ),
            const VerticalDivider(
              width: 8,
              color: Colors.transparent,
            ),
            Flexible(
              child: Text(
                item.description ?? '',
                style: TextStyles.regularBody14.copyWith(
                  color: ColorStyles.zodiacBlue,
                ),
                maxLines: 3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
