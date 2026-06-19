import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/asset_path.dart';
import 'circle_icon_button.dart';
class HomeAppBar extends StatelessWidget implements PreferredSize{
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(AssetPath.navLogoSvg),
      actions: [
        CircleIconButton(icon: Icons.person, onTap: () {  },),
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