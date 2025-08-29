import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/utils/constants/image_string.dart';
import '../../ui_helper/ui_helper.dart';
import '../../widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController email_Controller = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController NewPassWordController = TextEditingController();

  String? receivedOtp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: buildCustomAppBar(titleText: "LOGO"),
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: SvgPicture.asset(
            ImageString.jobPortalLogo,
            height: 30,
            fit: BoxFit.contain,
            allowDrawingOutsideViewBox: true, // optional
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/Icons/message_icon.svg"),
            padding: const EdgeInsets.only(right: 20.0),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/Icons/notifications_icon.svg"),
            padding: const EdgeInsets.only(right: 20.0),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 24.0, top: 7.0, left: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Forgot Password",
                  style: mTextStyle32(mColor: Colors.black)),
              const SizedBox(height: 20),
              Text("Email", style: mTextStyle12()),
              CustomTextField(
                controller: email_Controller,
                hintText: "AmanGupta@gmail.com",
                // fillColor: const Color(0xffFFF7FB),
              ),
              const SizedBox(height: 20),
              commonRedContainer(
                text: "Get OTP",
                onTap: () {
                  final email = email_Controller.text.trim();

                  if (email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter email or phone number"),
                      ),
                    );
                  } else {
                    // context.read<ForgotPasswordBloc>().add(
                    //       SendForgotPasswordEmail(email: email),
                    //     );
                  }
                },
              ),
              const SizedBox(height: 12),
              if (receivedOtp != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    "Received OTP: $receivedOtp",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              Text("Enter OTP to verify Email or Phone number",
                  style: mTextStyle12()),
              CustomTextField(
                controller: otpController,
                hintText: "Enter OTP",
                // fillColor: const Color(0xffFFF7FB),
              ),
              const SizedBox(height: 20),
              Text("New Password", style: mTextStyle12()),
              CustomTextField(
                controller: passwordController,
                hintText: "******",
                // fillColor: const Color(0xffFFF7FB),
                suffixIcon: Icons.visibility_off_outlined,
              ),
              const SizedBox(height: 20),
              Text("Re-type Password", style: mTextStyle12()),
              CustomTextField(
                controller: NewPassWordController,
                hintText: "******",
                // fillColor: const Color(0xffFFF7FB),
                suffixIcon: Icons.visibility_off_outlined,
              ),
              const SizedBox(height: 25),
              Center(
                child: SizedBox(
                  width: 150,
                  child: nextButton(
                    title: "Save Changes",
                    onTap: () {
                      final email = email_Controller.text.trim();
                      final otp = otpController.text.trim();
                      final newPassword = passwordController.text.trim();
                      final confirmPassword = NewPassWordController.text.trim();
                      if (email.isEmpty ||
                          otp.isEmpty ||
                          newPassword.isEmpty ||
                          confirmPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("All fields are required")),
                        );
                        return;
                      }
                      if (newPassword != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Passwords do not match")),
                        );
                        return;
                      }
                      // context.read<ResetPasswordBloc>().add(
                      //       ResetPasswordRequestEvent(
                      //         email: email,
                      //         otp: otp,
                      //         newPassword: newPassword,
                      //       ),
                      //     );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _extractOtp(String message) {
    final match = RegExp(r'\d{4,6}').firstMatch(message);
    return match?.group(0);
  }
}
