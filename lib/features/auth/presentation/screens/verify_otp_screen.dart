import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../app/app_colors.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/snack_bar_message.dart';
import '../../data/models/verify_otp_params.dart';
import '../provider/otp_timer_provider.dart';
import '../provider/verify_otp_provider.dart';
import '../widgets/app_logo.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});

  final String email;

  static const String name='/verify-otp';

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  final PinInputController _otpTEController=PinInputController();
  final OtpTimerProvider _otpTimerProvider = OtpTimerProvider(30);

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  final VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _otpTimerProvider.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme=TextTheme.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _otpTimerProvider),
        ChangeNotifierProvider.value(value: _verifyOtpProvider),
      ],
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
                    Consumer<VerifyOtpProvider>(
                      builder: (context,_,_) {
                        if(_verifyOtpProvider.verifyOtInProgress){
                          return CenteredProgressIndicator();
                        }
                        return FilledButton(onPressed: _onTapVerifyOtpButton, child: Text('Verify'));
                      }
                    ),
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
  void _onTapVerifyOtpButton(){
    if(_formKey.currentState!.validate()){
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp()async{
    final bool isSuccess = await _verifyOtpProvider.verifyOtp(
      VerifyOtpParams(email: '', otp: _otpTEController.text),
    );
    if (isSuccess){
      // navigate to next screen
    }else{
      showSnackBarMessage(context, _verifyOtpProvider.errorMessage!);
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

