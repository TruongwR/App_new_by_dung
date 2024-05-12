import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

import 'package:news_app_ui/routes/app_pages.dart';
import 'package:news_app_ui/utils/app_style.dart';
import 'package:news_app_ui/utils/kbutton.dart';

class AppBarLight extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? action;
  final bool? showback;

  const AppBarLight({
    required this.title,
    this.action,
    GestureTapCallback? onBack,
    this.showback,
    super.key,
  });

  static List<Widget> actionsBar() {
    const number = 0; //number notification;
    return [
      Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: badges.Badge(
          badgeContent: const Text(
            number > 0 ? '$number' : '',
            style: TextStyle(color: Colors.white),
          ),
          badgeStyle: const badges.BadgeStyle(badgeColor: ColorsConst.primary4),
          showBadge: number != 0,
          position: badges.BadgePosition.topStart(top: -2, start: 30),
          child: IconButton(
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: ColorsConst.white,
            ),
            onPressed: () {},
          ),
        ),
      ),
      IconButton(
        padding: const EdgeInsets.only(right: 8.0),
        constraints: const BoxConstraints(),
        onPressed: () {
          Get.toNamed(Routes.DETAIL_PROFILE);
        },
        icon: const Icon(Icons.person_4_outlined, size: 18),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsConst.white,
      elevation: 0.5,
      centerTitle: true,
      leading: Visibility(visible: showback ?? false, child: const KBackButton()),
      title: title != null
          ? Text(
              title!,
              style: Styles.button1.neutral2(context),
            )
          : null,
      actions: action ?? actionsBar(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
