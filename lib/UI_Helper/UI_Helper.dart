import 'package:flutter/material.dart';

class AppColors {
  static const Color mainIndigoColor = Color(0xff032466);
  static const Color mainRedColor = Color(0xffF03729);
  static const Color textSize12Color = Color(0xff6C7278);
  static const Color textSize14Color = Color(0xff1A1C1E);
  static const Color blueTextColor = Color(0xff4D81E7);
}

TextStyle mTextStyle12(
    {Color mColor = AppColors.textSize12Color,
    FontWeight mFontWeight = FontWeight.w500}) {
  return TextStyle(
      fontSize: 12,
      color: mColor,
      fontWeight: mFontWeight,
      fontFamily: "Inter");
}

TextStyle mTextStyle14(
    {Color mColor = AppColors.textSize14Color,
    FontWeight mFontWeight = FontWeight.w500}) {
  return TextStyle(
      fontSize: 14,
      color: mColor,
      fontWeight: mFontWeight,
      fontFamily: "Inter");
}

TextStyle mTextStyle15(
    {Color mColor = Colors.white, FontWeight mFontWeight = FontWeight.w500}) {
  return TextStyle(
      fontSize: 15,
      color: mColor,
      fontWeight: mFontWeight,
      fontFamily: "Inter");
}

TextStyle mTextStyle16(
    {Color mColor = Colors.white, FontWeight mFontWeight = FontWeight.w500}) {
  return TextStyle(
      fontSize: 16,
      color: mColor,
      fontWeight: mFontWeight,
      fontFamily: "Inter");
}

TextStyle mTextStyle32(
    {Color mColor = Colors.white, FontWeight mFontWeight = FontWeight.w700}) {
  return TextStyle(
      fontSize: 32,
      color: mColor,
      fontWeight: mFontWeight,
      fontFamily: "Inter");
}

Widget mSpacer({mHeight = 22.0}) {
  return SizedBox(
    height: mHeight,
  );
}
