import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/remote_signup_bloc/remote_signup_bloc.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/remote_signup_bloc/remote_signup_event.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/verify_otp_bloc/verify_otp_event.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/verify_otp_bloc/verify_otp_state.dart';
import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import '../../../login/presentation/views/login_page_first_view.dart';
import '../../../detailed_signup_student/presentation/views/signup_as_anyone_view.dart';

class SignUpStudent_2 extends StatefulWidget {
  final String Email;
  const SignUpStudent_2({super.key, required this.Email});

  @override
  State<SignUpStudent_2> createState() => _SignUpStudent_2State();
}

class _SignUpStudent_2State extends State<SignUpStudent_2> {
  TextEditingController enterOTP = TextEditingController();
  Timer? _timer;
  int _start = 15;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _canResend = false;
      _start = 15;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void resendOtp() {
    Map<String, dynamic> emailMap = {'email': widget.Email};
    context.read<RemoteSignupBloc>().add(RemoteSingupSendOtpEmail(emailMap));
    showSnackbar('OTP resent to your email.', context);
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(""),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupAsAnyOne(email: widget.Email),
                  ),
                );
              },
              icon: const Icon(Icons.double_arrow),
            )
          ],
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 710,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mSpacer(mHeight: 20.0),
                    Text("Verify your email",
                        style: mTextStyle32(mColor: const Color(0xff1A1C1E))),
                    mSpacer(),
                    Text(
                      "One Time Password (OTP) has been sent on ${widget.Email}",
                      style: mTextStyle12(),
                    ),
                    mSpacer(mHeight: 26.0),
                    Text("Enter OTP to verify your email",
                        style: mTextStyle12()),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: double.infinity,
                      child: CustomTextField(
                        controller: enterOTP,
                        hintText: "Enter OTP",
                        fillColor: Colors.white,
                      ),
                    ),
                    mSpacer(),
                    BlocListener<VerifyOtpBloc, VerifyOtpState>(
                      listener: (context, state) {
                        if (state is VerifyOtpLoaded) {
                          final data = state.verifyOtpEntity;

                          if (data.message == "email verification successful") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SignupAsAnyOne(email: widget.Email),
                              ),
                            );
                          } else {
                            showSnackbar("OTP could not be verified.", context);
                          }
                        }
                      },
                      child: commonRedContainer(
                        text: "Verify Email",
                        onTap: () {
                          Map<String, dynamic> emailOtpMap = {
                            "email": widget.Email,
                            "otp": enterOTP.text.trim()
                          };
                          context
                              .read<VerifyOtpBloc>()
                              .add(LoadVerifyOtp(emailOtpMap));
                        },
                      ),
                    ),
                    mSpacer(),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: _canResend ? resendOtp : null,
                            child: Text(
                              _canResend
                                  ? "Resend code"
                                  : "Resend in $_start seconds",
                              style: mTextStyle12(
                                mColor: _canResend
                                    ? AppColors.blueTextColor
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    mSpacer(mHeight: 44.0),
                    Center(
                      child: SizedBox(
                        height: 36,
                        width: 313,
                        child: Text(
                          "Can't find our mail? Check your spam folder or promotions tab too",
                          style: mTextStyle12(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    mSpacer(mHeight: 243.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?", style: mTextStyle12()),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogInPage1(),
                              ),
                            );
                          },
                          child: Text(
                            " Login",
                            style: mTextStyle12(
                              mColor: AppColors.blueTextColor,
                              mFontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }
}
