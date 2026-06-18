import 'package:crafty_bay/features/app/app_colors.dart';
import 'package:crafty_bay/features/app/extensions/localization_extension.dart';
import 'package:crafty_bay/features/auth/presentation/screens/provider/otp_timer_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/presentation/utils/validators.dart';
import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  static const String name='/verify-otp';

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  final PinInputController _otpTEController=PinInputController();
  final OtpTimerProvider _otpTimerProvider = OtpTimerProvider(30);

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _otpTimerProvider.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme=TextTheme.of(context);
    return ChangeNotifierProvider.value(
      value: _otpTimerProvider,
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
                    Text('Verify your OTP',style: textTheme.titleLarge),
                    SizedBox(height: 6,),
                    Text('Enter your otp that has been send to your email address',style: textTheme.labelLarge,),
                    SizedBox(height: 24,),
                    MaterialPinField(
                      length: 4,
                      pinController: _otpTEController,
                      keyboardType: .number,
                      theme: MaterialPinTheme(
                        fillColor: Colors.transparent,
                        focusedFillColor: Colors.transparent,
                        focusedBorderColor: AppColors.themeColor,
                      ),
                    ),
                    SizedBox(height: 16,),
                    FilledButton(onPressed: _onTapSignInButton, child: Text('Sing-in')),
                    SizedBox(height: 16,),
                    Consumer<OtpTimerProvider>(
                      builder: (context,_,_) {
                        if (_otpTimerProvider.secondsLeft == 0) {
                          return TextButton(
                              onPressed: _onTapResendOTP, child: Text(
                              "Resend OTP"));
                        } else {
                          return RichText(text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: 'Resend OTP after '),
                                TextSpan(text:'${_otpTimerProvider.secondsLeft}s', style: TextStyle(color: AppColors.themeColor)),
                              ]
                          ));
                        }
                      }
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
      //TODO:call sign in api
    }
  }
  void _onTapResendOTP(){
    _otpTimerProvider.startTimer();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _otpTEController.dispose();
  }
}

