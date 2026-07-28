import 'package:flutter/material.dart';
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key, required this.icon, required this.onTap, this.iconColor,
  });
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        child: Icon(icon,
          color: iconColor ?? (isDark ? Colors.grey.shade400 : Colors.grey.shade500),
          size: 20,),
      ),
    );
  }
}