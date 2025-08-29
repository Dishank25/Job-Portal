import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../views/signup_student/presentation/views/create_account.dart';

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

class CustomButton1 extends StatelessWidget {
  /// The text to display on the button
  final String text;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// Optional: Customize text style
  final TextStyle? textStyle;

  /// Optional: Button width (default: 355)
  final double width;

  /// Optional: Button height (default: 48)
  final double height;

  const CustomButton1({
    Key? key,
    required this.text,
    this.onPressed,
    this.textStyle,
    this.width = double.infinity,
    this.height = 48.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(240, 55, 41, 1), // Base red
          elevation: 0,
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 10), // LTRB padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: BorderSide.none, // Remove default side
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(240, 55, 41, 1),
                Color.fromRGBO(240, 55, 41, 1),
              ],
            ),
            // Add drop shadow
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(240, 55, 41, 1),
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Text(
                text,
                style: mTextStyle16()
            ),
          ),
        ),
      ),
    );
  }
}

void showSnackbarWithAction(
    BuildContext context, {
      required String message,
      required String actionLabel,
      required VoidCallback onPressed,
    }) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: actionLabel,
          onPressed: onPressed,
        ),
      ),
    );
}

void showLoginFailureDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, size: 50, color: Colors.blue.shade600),
                const SizedBox(height: 16),
                Text("No account found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  "We couldn't find an account with this email. Would you like to create one?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => CreateAccount()),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: const Text("Sign Up"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}