import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/crafty_bay_app.dart';
import '../../../../app/extensions/localization_extension.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../../app/providers/locale_provider.dart';
import '../../../../app/providers/theme_mode_provider.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
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
                        user != null ? '${user.firstName} ${user.lastName}' : context.localization.guest,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? context.localization.notLoggedIn,
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
                            context.localization.login,
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
            const SizedBox(height: 20),
            const Divider(),

            InkWell(
              onTap: () => _showThemeOptions(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Consumer<ThemeModeProvider>(
                  builder: (context, themeModeProvider, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.dark_mode_outlined, color: AppColors.themeColor),
                            const SizedBox(width: 12),
                            Text(context.localization.theme, style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Text(
                          _themeModeLabel(themeModeProvider.themeMode),
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 8),

            InkWell(
              onTap: () => _showLanguageOptions(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Consumer<LocaleProvider>(
                    builder: (context, localeProvider, _) {
                      final bool isEnglish = localeProvider.currentLocale.languageCode == 'en';
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.language, color: AppColors.themeColor),
                              const SizedBox(width: 12),
                               Text(context.localization.language, style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Text(
                            isEnglish ? 'English' : 'বাংলা',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      );
                    }
                ),
              ),
            ),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: isLoggedIn ? Colors.red : Colors.grey,
                ),
                onPressed: () => _onTapLogout(context, isLoggedIn),
                child: Text(context.localization.logout),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _showThemeOptions(BuildContext context){
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Consumer<ThemeModeProvider>(
          builder: (context, themeModeProvider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _selectableOption(
                    context,
                    label: context.localization.system,
                    isSelected: themeModeProvider.themeMode == ThemeMode.system,
                    onTap: (){
                      themeModeProvider.changeThemeMode(ThemeMode.system);
                      Navigator.pop(context);
                    },
                  ),
                  _selectableOption(
                    context,
                    label: context.localization.light,
                    isSelected: themeModeProvider.themeMode == ThemeMode.light,
                    onTap: (){
                      themeModeProvider.changeThemeMode(ThemeMode.light);
                      Navigator.pop(context);
                    },
                  ),
                  _selectableOption(
                    context,
                    label: context.localization.dark,
                    isSelected: themeModeProvider.themeMode == ThemeMode.dark,
                    onTap: (){
                      themeModeProvider.changeThemeMode(ThemeMode.dark);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          }
      );
    },
  );
}

String _themeModeLabel(ThemeMode mode){
  switch(mode){
    case ThemeMode.light:
      return 'Light';
    case ThemeMode.dark:
      return 'Dark';
    case ThemeMode.system:
      return 'System';
  }
}

void _showLanguageOptions(BuildContext context){
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Consumer<LocaleProvider>(
          builder: (context, localeProvider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _selectableOption(
                    context,
                    label: 'English',
                    isSelected: localeProvider.currentLocale.languageCode == 'en',
                    onTap: ()async{
                      await localeProvider.changeLocale(Locale('en'));
                      if(context.mounted){
                        Navigator.pop(context);
                      }
                    },
                  ),
                  _selectableOption(
                    context,
                    label: 'বাংলা',
                    isSelected: localeProvider.currentLocale.languageCode == 'bn',
                    onTap: ()async{
                      await localeProvider.changeLocale(Locale('bn'));
                      if(context.mounted){
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          }
      );
    },
  );
}

Widget _selectableOption(BuildContext context, {required String label, required bool isSelected, required VoidCallback onTap}){
  return ListTile(
    title: Text(label, style: const TextStyle(fontSize: 16)),
    trailing: isSelected ? Icon(Icons.check, color: AppColors.themeColor) : null,
    onTap: onTap,
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
