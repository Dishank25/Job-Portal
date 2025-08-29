import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import '../../../signup_student/presentation/views/create_account.dart';
import 'EnterEmailOTpScreen.dart';

class UserEmailVerificationAfterRegistration extends StatefulWidget {
  const UserEmailVerificationAfterRegistration({super.key});

  @override
  State<UserEmailVerificationAfterRegistration> createState() =>
      _UserEmailVerificationAfterRegistration();
}

class _UserEmailVerificationAfterRegistration
    extends State<UserEmailVerificationAfterRegistration> {
  TextEditingController emailOTPController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "LOGO",
              style: mTextStyle12(mColor: Colors.white),
            ),
          ),
          backgroundColor: TColors.primary),
      body: Column(
        children: [
          signInHeader(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAccount()),
              );
            },
          ),
          mSpacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter your Email",
                    style: mTextStyle14(mColor: Colors.grey.shade600)),
                SizedBox(
                  height: 3,
                ),
                CustomTextField(
                    controller: emailOTPController,
                    hintText: "Enter your email"),
                SizedBox(height: 30),
                commonRedContainer(
                  text: "Get OTP",
                  onTap: () {
                    // context.read<SendOTPBloc>().add(
                    //     TriggerSendOTPEvent(email: emailOTPController.text.trim()));
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "Resend code in 15 seconds",
                      style: mTextStyle12(mColor: AppColors.blueTextColor),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Can’t find our email? Check your spam folder or promotions tab too!",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
