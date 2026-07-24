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
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon,color: iconColor ?? Colors.grey.shade500,size: 20,),
      ),
    );
  }
}