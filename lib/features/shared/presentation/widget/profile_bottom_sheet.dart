import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../../app/crafty_bay_app.dart';
import '../screens/main_nav_holder_screen.dart';

Future<void> showProfileBottomSheet(BuildContext context) async {
  final bool isLoggedIn = await AuthController.isLoggedIn();
  final user = AuthController.user;

  if (context.mounted == false) return;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.themeColor.withAlpha(30),
                  child: Icon(Icons.person, color: AppColors.themeColor, size: 32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        user != null ? '${user.firstName} ${user.lastName}' : 'Guest',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? 'Not logged in',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                if (isLoggedIn == false)
                  GestureDetector(
                    onTap: () => _onTapLoginIcon(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.themeColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.login, color: AppColors.themeColor, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            'Login',
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: isLoggedIn ? AppColors.themeColor : Colors.grey,
                ),
                onPressed: () => _onTapLogout(context, isLoggedIn),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _onTapLoginIcon(BuildContext context) {
  Navigator.pop(context);
  Navigator.pushNamed(context, SignInScreen.name);
}

Future<void> _onTapLogout(BuildContext context, bool isLoggedIn) async {
  if (isLoggedIn == false) {
    return;
  }

  await AuthController.clearUserData();

  Navigator.pop(context);

  Navigator.pushNamedAndRemoveUntil(
    CraftyBayApp.navigatorKey.currentContext!,
    MainNavHolderScreen.name,
        (route) => false,
  );
}