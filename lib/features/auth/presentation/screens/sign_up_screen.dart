import 'package:crafty_bay/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/localization_extension.dart';
import '../../../shared/presentation/utils/validators.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/snack_bar_message.dart';
import '../../data/models/sign_up_params.dart';
import '../provider/sign_up_provider.dart';
import '../widgets/app_logo.dart';

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

  final SignUpProvider _signUpProvider = SignUpProvider();

  bool _enableButton = false;

  @override
  Widget build(BuildContext context) {
    final textTheme=TextTheme.of(context);
    return ChangeNotifierProvider.value(
      value: _signUpProvider,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                autovalidateMode: .onUserInteraction,
                onChanged: _checkIfFormValid,
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    AppLogo(width: 100,),
                    SizedBox(height: 10,),
                    Text(context.localization.createAccount,style: textTheme.titleLarge),
                    SizedBox(height: 6,),
                    Text(context.localization.signUpSubtitle,style: textTheme.labelLarge,),
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
                    Consumer<SignUpProvider>(
                      builder: (context,_,_) {
                        if(_signUpProvider.signUpInInProgress){
                          return CenteredProgressIndicator();
                        }
                        return FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: _enableButton == false ? Colors.grey : null,
                            ),
                            onPressed: _enableButton ? _onTapSignUpButton : null,
                            child: Text(context.localization.signUp),
                        );
                      }
                    ),
                    SizedBox(height: 15,),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                        children: [
                          TextSpan(text: context.localization.alreadyHaveAccount),
                          TextSpan(
                            text: context.localization.signIn,
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
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
    Navigator.pop(context);
  }

  void _checkIfFormValid(){
    if(_formKey.currentState!.validate()){
     _enableButton = true;
    }else{
      _enableButton = false;
    }
    setState(() {});
  }

  void _onTapSignUpButton(){
    if(_formKey.currentState!.validate()){
      _signUp();
    }
  }
  Future<void> _signUp()async{
    SignUpParams params = SignUpParams(
        email: _emailTEController.text.trim(),
        firstName: _firstnameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        city: _cityTEController.text.trim(),
        phone: _phoneTEController.text.trim(),
        password: _passwordTEController.text,
    );
    final bool isSuccess = await _signUpProvider.signUp(params);
    if(isSuccess && mounted){
      Navigator.pushNamed(context, VerifyOtpScreen.name, arguments: _emailTEController.text.trim());
    }else if (mounted){
      showSnackBarMessage(context, _signUpProvider.errorMessage!);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstnameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    super.dispose();
  }
}

