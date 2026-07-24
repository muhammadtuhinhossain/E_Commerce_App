import 'package:crafty_bay/features/app/app_colors.dart';
import 'package:crafty_bay/features/shared/presentation/widget/profile_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/asset_path.dart';
import '../../../app/providers/auth_controller.dart';
import 'circle_icon_button.dart';
class HomeAppBar extends StatelessWidget implements PreferredSize{
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = AuthController.accessToken != null;

    return AppBar(
      title: SvgPicture.asset(AssetPath.navLogoSvg),
      actions: [
        CircleIconButton(
          icon: Icons.person,
          iconColor: isLoggedIn ? AppColors.themeColor : null,
          onTap: () => showProfileBottomSheet(context),
       ),
        SizedBox(width: 8,),
        CircleIconButton(icon: Icons.call, onTap: () {  },),
        SizedBox(width: 8,),
        CircleIconButton(icon: Icons.notifications_active_outlined, onTap: () {  },),
        SizedBox(width: 8,),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}