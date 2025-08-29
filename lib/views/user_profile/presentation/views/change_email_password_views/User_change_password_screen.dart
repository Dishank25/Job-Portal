import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../ui_helper/ui_helper.dart';
import '../../../../../widgets/widgets.dart';

class UserChangePasswordScreen extends StatelessWidget {
  TextEditingController oldPassWordController = TextEditingController();
  TextEditingController NewPassWordController = TextEditingController();
  TextEditingController Re_enterPassWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Icons/message_icon.svg"),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Icons/notifications_icon.svg"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change Password",
              style: mTextStyle32(mColor: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Old Password",
              style: mTextStyle12(),
            ),
            CustomTextField(
                controller: oldPassWordController,
                hintText: "******",
                suffixIcon: Icons.visibility_off_outlined),
            SizedBox(
              height: 15,
            ),
            Text("New Password", style: mTextStyle12()),
            CustomTextField(
              controller: NewPassWordController,
              hintText: "******",
              suffixIcon: Icons.visibility_off_outlined,
            ),
            SizedBox(
              height: 15,
            ),
            Text("Re-enter Password", style: mTextStyle12()),
            CustomTextField(
              controller: Re_enterPassWordController,
              hintText: "******",
              suffixIcon: Icons.visibility_off_outlined,
            ),
            SizedBox(
              height: 15,
            ),
            Center(child: nextButton(title: "Save Changes", onTap: () {})),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
