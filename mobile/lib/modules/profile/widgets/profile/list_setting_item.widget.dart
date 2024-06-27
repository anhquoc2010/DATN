import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/profile/widgets/profile/setting_item.widget.dart';
import 'package:mobile/configs/router/app_routes.dart';

class ListSettingItem extends StatefulWidget {
  const ListSettingItem({super.key});

  @override
  State<ListSettingItem> createState() => _ListSettingItemState();
}

class _ListSettingItemState extends State<ListSettingItem> {
  String _localeName = '';

  void _getLocales(BuildContext context) {
    setState(() {
      _localeName = Localizations.localeOf(context).languageCode.toUpperCase();
    });
  }

  Future<void> _onSwitchLanguage(BuildContext context) async {
    if (_localeName == 'EN') {
      EasyLocalization.of(context)!.setLocale(
        const Locale('vi', 'VN'),
      );
    } else {
      EasyLocalization.of(context)!.setLocale(
        const Locale('en', 'US'),
      );
    }
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.root,
        (route) => false,
      );
    }
  }

  void _switchMode(BuildContext context) {
    if (context.read<AuthBloc>().state.status.isAuthenticatedOrganization) {
      context.read<AuthBloc>().add(const AuthModeSwitch(null));
    } else {
      Navigator.of(context).pushNamed(AppRoutes.organizationManagement);
    }
  }

  @override
  Widget build(BuildContext context) {
    _getLocales(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.profile_preferences.tr(),
          style: TextStyles.s17MediumText,
        ),
        // SettingItem(
        //   title: LocaleKeys.profile_setting.tr(),
        //   icon: Assets.icons.icSetting.image(),
        //   onTap: () {},
        // ),
        // SettingItem(
        //   title: LocaleKeys.profile_about_us.tr(),
        //   icon: Assets.icons.icStar.image(),
        //   onTap: () {},
        // ),
        // SettingItem(
        //   title: LocaleKeys.profile_share_this_app.tr(),
        //   icon: Assets.icons.icShare.image(),
        //   onTap: () {},
        // ),
        // SettingItem(
        //   title: LocaleKeys.profile_help_center.tr(),
        //   icon: Assets.icons.icSupport.image(),
        //   onTap: () {},
        // ),
        // SettingItem(
        //   title: LocaleKeys.profile_delete_account.tr(),
        //   icon: Assets.icons.icRemoveUser.image(),
        //   onTap: () {},
        // ),
        SettingItem(
          title: _localeName == 'EN'
              ? LocaleKeys.profile_switch_to_vietnamese.tr()
              : LocaleKeys.profile_switch_to_english.tr(),
          icon: Assets.icons.icInternet.image(color: Colors.green),
          onTap: () {
            _onSwitchLanguage(context);
          },
        ),
        SettingItem(
          title:
              context.read<AuthBloc>().state.status.isAuthenticatedOrganization
                  ? LocaleKeys.profile_switch_to_myaccount.tr()
                  : LocaleKeys.profile_my_organizations.tr(),
          icon: Assets.icons.icSwitch.image(),
          onTap: () {
            _switchMode(context);
          },
        ),
        SettingItem(
          title: LocaleKeys.profile_logout.tr(),
          icon: Assets.icons.icLogout.image(),
          onTap: () {
            context.read<AuthBloc>().add(const AuthUserAuthInfoSet(null));
          },
        ),
      ],
    );
  }
}
