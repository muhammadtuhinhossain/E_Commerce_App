import 'package:crafty_bay/features/Reviews/presentation/screens/input_review_screen.dart';
import 'package:crafty_bay/features/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/data/models/sign_In_params.dart';
import 'package:crafty_bay/features/auth/presentation/provider/sign_in_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/presentation/screens/main_nav_holder_screen.dart';
import 'package:crafty_bay/features/shared/presentation/utils/validators.dart';
import 'package:crafty_bay/features/shared/presentation/widget/snack_bar_message.dart';
import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widget/centered_progress_indicator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name='/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _emailTEController= TextEditingController();
  final TextEditingController _passwordTEController= TextEditingController();

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  final SignInProvider _signInProvider = SignInProvider();

  @override
  Widget build(BuildContext context) {
    final textTheme=TextTheme.of(context);
    return ChangeNotifierProvider.value(
      value: _signInProvider,
      child: Scaffold(
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
                    Text('Welcome Back',style: textTheme.titleLarge),
                    SizedBox(height: 6,),
                    Text('sing in with email and password',style: textTheme.labelLarge,),
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
                    Consumer<SignInProvider>(
                      builder: (context,_,_) {
                        if(_signInProvider.signInProgress){
                          return CenteredProgressIndicator();
                        }
                        return FilledButton(onPressed: _onTapSignInButton, child: Text('Sing-in'));
                      }
                    ),
                    TextButton(onPressed: _onTapSignUpButton, child: Text("Don't have an account? Sing up")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _onTapSignInButton(){
    if(_formKey.currentState!.validate()){
      // Navigator.pushNamed(context, InputReviewScreen.name);
      // //TODO:call sign in api
      _signIn();
    }
  }

  Future<void> _signIn()async{
    SignInParams params = SignInParams(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text
    );
    final isSuccess = await _signInProvider.signIn(params);
    if(mounted == false){
      return;
    }
    if(isSuccess){
      Navigator.pushNamedAndRemoveUntil(context, MainNavHolderScreen.name, (predicate)=> false);
    }else{
      showSnackBarMessage(context, _signInProvider.errorMessage!);
    }
  }

  void _onTapSignUpButton(){
    Navigator.pushNamed(context, SignUpScreen.name);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}

