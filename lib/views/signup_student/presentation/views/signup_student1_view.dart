import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/views/login/presentation/views/login_page_first_view.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/remote_signup_bloc/remote_signup_bloc.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/remote_signup_bloc/remote_signup_event.dart';
import 'package:job_portal/views/signup_student/presentation/bloc/remote_signup_bloc/remote_signup_state.dart';
import 'package:job_portal/views/signup_student/presentation/views/signup_student2_view.dart';
import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import 'dart:developer' as developer show log;

import '../../../detailed_signup_student/presentation/views/signup_as_anyone_view.dart';

class SignUpStudent1 extends StatefulWidget {
  final String user_type;

  const SignUpStudent1({super.key, required this.user_type});

  @override
  State<SignUpStudent1> createState() => _SignUpStudent1State();
}

class _SignUpStudent1State extends State<SignUpStudent1> {
  final _formKey = GlobalKey<FormState>();
  final first_nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignUpStudent_2(
                    Email: emailController.text.trim(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.double_arrow),
          )

        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sign Up",
                    style: mTextStyle32(mColor: const Color(0xff1A1C1E))),
                mSpacer(),
                Text("Create an account to continue!", style: mTextStyle14()),
                mSpacer(mHeight: 24.0),
                Text("First Name", style: mTextStyle12()),
                CustomTextField(
                  controller: first_nameController,
                  hintText: "Aman",
                  suffixIcon: Icons.person,
                  // fillColor: Colors.white,
                  validator: (value) => value == null || value.isEmpty
                      ? 'First name required'
                      : null,
                ),
                mSpacer(mHeight: 15.0),
                Text("Last Name", style: mTextStyle12()),
                CustomTextField(
                  controller: surnameController,
                  hintText: "Gupta",
                  // fillColor: Color(0xffFFF7FB),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Last name required'
                      : null,
                ),
                mSpacer(mHeight: 15.0),
                Text("Phone Number", style: mTextStyle12()),
                // CustomTextField(
                //   controller: phoneController,
                //   hintText: "7895674320",
                //   keyboardType: TextInputType.number,
                //   suffixIcon: Icons.call,
                //   // fillColor: Color(0xffFFF7FB),
                //   validator: (value) {
                //     if (value == null || value.isEmpty)
                //       return 'Phone Number required';
                //     if (value.length < 10 || value.length > 10)
                //       return 'Phone Number must be 10 digits';
                //     return null;
                //   },
                // ),
                CustomPhoneField(
                  controller: phoneController,
                ),
                mSpacer(mHeight: 0.0),
                Text("Email", style: mTextStyle12()),
                CustomTextField(
                  controller: emailController,
                  hintText: "abc@gmail.com",
                  suffixIcon: Icons.email,
                  // fillColor: Color(0xffFFF7FB),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email required';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                      return 'Enter a valid email';
                    return null;
                  },
                ),

                mSpacer(mHeight: 15.0),
                Text("Password", style: mTextStyle12()),
                CustomTextField(
                  controller: passwordController,
                  hintText: "∗∗∗∗∗∗∗∗∗∗",
                  isPasswordField: true,
                  suffixIcon: Icons.visibility_off_outlined,
                  // fillColor: Color(0xffFFF7FB),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password required';
                    if (value.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                mSpacer(),

                // commonRedContainer(
                //   text: "Register",
                //   onTap: () {
                //     if (_formKey.currentState!.validate()) {
                //       final body = {
                //         "first_name": first_nameController.text.trim(),
                //         "last_name": surnameController.text.trim(),
                //         "email": emailController.text.trim(),
                //         "phone": phoneController.text.trim(),
                //         "password": passwordController.text,
                //         "user_role": widget.user_type,
                //       };
                //       // context.read<RegisterUserBloc>().add(
                //       //   RegisteredUserEvent(bodyParams: body),
                //       // );
                //       // context.read<SendOTPBloc>().add(
                //       //   TriggerSendOTPEvent(email: emailController.text.trim()),
                //       // );
                //       developer.log('Registeration map print : $body');
                //       context
                //           .read<RemoteSignupBloc>()
                //           .add(RemoteSignupData(body));
                //       BlocListener<RemoteSignupBloc, RemoteSignupState>(
                //           listener: (context, state) {
                //         if (state is RemoteSignupError) {
                //           showSnackbar(
                //               'Some error occured while signing up.', context);
                //         } else if (state is RemoteSignupDone) {
                //           final data = state.signUpUserResponse;
                //           developer.log(data.message);
                //           if (data.message == 'Email already exists') {
                //           } else {
                //             Navigator.of(context).push(MaterialPageRoute(
                //                 builder: (context) => SignUpStudent_2(
                //                     Email: emailController.text.trim())));
                //           }
                //         }
                //       });
                //       showSnackbar('Email already exists', context);
                //       // Navigator.of(context).push(MaterialPageRoute(
                //       //     builder: (context) => SignUpStudent_2(
                //       //         Email: emailController.text.trim())));
                //     }
                //   },
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("By signing up, you agree to our",
                        style: mTextStyle12()),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        " Terms and Conditions",
                        style: mTextStyle14(
                          mFontWeight: FontWeight.w700,
                          mColor: const Color.fromARGB(255, 17, 24, 39),
                        ),
                      ),
                    )
                  ],
                ),
                mSpacer(),
                BlocListener<RemoteSignupBloc, RemoteSignupState>(
                  listener: (context, state) {
                    if (state is RemoteSignupError) {
                      showSnackbar(
                          'Some error occured while signing up.', context);
                    } else if (state is RemoteSignupDone) {
                      final data = state.signUpUserResponse;

                      // developer.log(data.message);

                      if (data.message == 'Email already exists') {
                        showSnackbar('Email already exists', context);
                        // this is for temp testing of send otp api
                        // Map<String, dynamic> emailMap = {
                        //   'email': emailController.text.trim()
                        // };
                        // context
                        //     .read<RemoteSignupBloc>()
                        //     .add(RemoteSingupSendOtpEmail(emailMap));
                      } else {
                        Map<String, dynamic> emailMap = {};
                        if (data.user != null) {
                          emailMap.addAll({'email': data.user!.email});
                        }
                        final _prefs = sl<PreferencesManager>();
                        _prefs.setuser_id(data.user?.id.toString() ?? '00');
                        _prefs.setToken(data.token ?? '');
                        _prefs.setuser_type(data.user!.user_role);
                        context
                            .read<RemoteSignupBloc>()
                            .add(RemoteSingupSendOtpEmail(emailMap));
                        // commented cuz adding send otp email call here.
                        // showSnackbar('Please verify email.', context);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => SignUpStudent_2(
                        //         Email: emailController.text.trim())));
                      }
                    } else if (state is RemoteSignupSendOtpEmailDone) {
                      final data = state.sendOtp;

                      if (data.message ==
                          "OTP sent successfully to your email") {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpStudent_2(
                                Email: emailController.text.trim())));
                      }
                    } else if (state is RemoteSignupSendOtpEmailError) {
                      showSnackbar(
                          'Some error occured while sending otp. Please try resending otp.',
                          context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpStudent_2(
                              Email: emailController.text.trim())));
                    }
                  },
                  child: commonRedContainer(
                    text: "Register",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final body = {
                          "first_name": first_nameController.text.trim(),
                          "last_name": surnameController.text.trim(),
                          "email": emailController.text.trim(),
                          "phone": phoneController.text.trim(),
                          "password": passwordController.text,
                          "user_role": widget.user_type,
                        };

                        developer.log('Registration map print : $body');

                        // Navigate to SignupAsAnyOne with prefilled data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupAsAnyOne(
                              email: emailController.text.trim(),
                              firstName: first_nameController.text.trim(),
                              lastName: surnameController.text.trim(),
                              phone: phoneController.text.trim(),
                            ),
                          ),
                        );

                        // Trigger signup API
                        context.read<RemoteSignupBloc>().add(RemoteSignupData(body));
                      } else {
                        developer.log('Form validation failed');
                      }
                    },
                  ),
                ),

                mSpacer(mHeight: 20.0),
                dividerLine(),
                mSpacer(),
                belowBars(
                  text: "Sign up with Google",
                  imgUrl: "assets/Icons/google.svg",
                ),
                mSpacer(mHeight: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: mTextStyle12()),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LogInPage1()),
                        );
                      },
                      child: Text(
                        " Login",
                        style: mTextStyle14(
                          mColor: AppColors.blueTextColor,
                          mFontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
