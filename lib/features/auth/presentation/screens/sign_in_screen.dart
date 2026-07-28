import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/localization_extension.dart';
import '../../../shared/presentation/screens/main_nav_holder_screen.dart';
import '../../../shared/presentation/utils/validators.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/snack_bar_message.dart';
import '../../data/models/sign_In_params.dart';
import '../provider/sign_in_provider.dart';
import '../widgets/app_logo.dart';

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
                    Text(context.localization.welcomeBack,style: textTheme.titleLarge),
                    SizedBox(height: 6,),
                    Text(context.localization.signInSubtitle,style: textTheme.labelLarge,),
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
                        return FilledButton(onPressed: _onTapSignInButton, child: Text(context.localization.signIn));
                      }
                    ),
                    SizedBox(height: 15,),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                        children: [
                          TextSpan(text: context.localization.dontHaveAccount),
                          TextSpan(
                            text: context.localization.signUp,
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton,
                          ),
                        ],
                      ),
                    ),
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
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}

