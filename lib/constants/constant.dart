import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstantsUtils {
  static String? validateNameField(String value, BuildContext context) {
    if (value.isEmpty) {
            return "thisFieldRequired".tr;
 
    } else {
      return null;
    }
  }

  static String? validatePassword(String value, BuildContext context) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return "thisFieldRequired".tr;
    } else if (value.length < 6) {
      return "passwordMsg".tr;
    } else if (!regex.hasMatch(value)) {
      return "The password must be at least 8 characters long and in English only. It must contain at least one uppercase letter, one lowercase letter, one number, and one special character.";
    } else {
      return null;
    }
  }

  static String? validateConfirmPasswordField(
    String value,
    BuildContext context,
    String pass,
  ) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return "thisFieldRequired".tr;
    } else if (value.length < 6) {
      return "passwordMsg".tr;
    } else if (!regex.hasMatch(value)) {
      return "The password must be at least 8 characters long and in English only. It must contain at least one uppercase letter, one lowercase letter, one number, and one special character.";
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value, BuildContext context) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "thisFieldRequired".tr;
    } else if (!regExp.hasMatch(value)) {
      return "validPhone".tr;
    }
    return null;
  }

  static String? validateEmail(String value, BuildContext context) {
    String patttern =
        r"^[a-zA-Z0-9.!#$%'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]{2,})+$";

    RegExp regExp = RegExp(patttern);

    if (value.isEmpty) {
      return "thisFieldRequired".tr;
    } else if (!regExp.hasMatch(value)) {
      return "validEmail".tr;
    }
    return null;
  }
}
