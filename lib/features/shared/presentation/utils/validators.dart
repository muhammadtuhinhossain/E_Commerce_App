import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class Validators {
  static String? validateInput(String? input, String message){
    if(input == null || input.isEmpty){
      return message;
    }
    return null;
  }
  static String? validateEmail(String? input, BuildContext context){
    if(EmailValidator.validate(input ?? '')==false){
      return context.localization.enterAValidEmailAddress;
    }
    return null;
  }
  static String? validatePassword(String? input, BuildContext context){
    if((input ?? '').length <6){
      return context.localization.enterAPasswordMoreThanFive;
    }
    return null;
  }
  static String? validatePasswordConfirm(String? input, String password, BuildContext context){
    if(input == password){
      return context.localization.confirmPasswordDoesNotMatch;
    }
    return null;
  }
}