import 'package:crafty_bay/features/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/presentation/utils/validators.dart';
import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name='/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailTEController= TextEditingController();
  final TextEditingController _passwordTEController= TextEditingController();
  final TextEditingController _firstnameTEController= TextEditingController();
  final TextEditingController _lastNameTEController= TextEditingController();
  final TextEditingController _cityTEController= TextEditingController();
  final TextEditingController _phoneTEController= TextEditingController();

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme=TextTheme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: .onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 60,),
                  AppLogo(width: 100,),
                  SizedBox(height: 10,),
                  Text('Create an account',style: textTheme.titleLarge),
                  SizedBox(height: 6,),
                  Text('sing up with your email and password',style: textTheme.labelLarge,),
                  SizedBox(height: 24,),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: .next,
                    keyboardType: .emailAddress,
                    decoration: InputDecoration(
                      hintText: context.localization.email,
                      labelText: context.localization.email,
                    ),
                    validator: (String? value)=> Validators.validateEmail(value),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _firstnameTEController,
                    decoration: InputDecoration(
                      hintText: context.localization.first_name,
                      labelText: context.localization.last_name,
                    ),
                    validator: (input)=> Validators.validatePassword(input),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: InputDecoration(
                      hintText: context.localization.last_name,
                      labelText: context.localization.last_name,
                    ),
                    validator: (input)=> Validators.validatePassword(input),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _cityTEController,
                    decoration: InputDecoration(
                      hintText: context.localization.city,
                      labelText: context.localization.city,
                    ),
                    validator: (input)=> Validators.validatePassword(input),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _phoneTEController,
                    keyboardType: .number,
                    decoration: InputDecoration(
                      hintText: context.localization.phone,
                      labelText: context.localization.phone,
                    ),
                    validator: (input)=> Validators.validatePassword(input),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    obscuringCharacter: '*',
                    keyboardType: .number,
                    decoration: InputDecoration(
                      hintText: context.localization.password,
                      labelText: context.localization.password,
                    ),
                    validator: (input)=> Validators.validatePassword(input),
                  ),
                  SizedBox(height: 16,),
                  FilledButton(onPressed: _onTapSignUpButton, child: Text('Sing-up')),
                  TextButton(onPressed: _onTapSignInButton, child: Text("have an account? Sing in")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _onTapSignInButton(){
    Navigator.pop(context);
  }
  void _onTapSignUpButton(){
    Navigator.pushNamed(context, VerifyOtpScreen.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstnameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
  }
}

