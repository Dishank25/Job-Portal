import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/views/job_related/presentation/views/job_details_view.dart';
import 'package:job_portal/views/signup_recruiter/presentation/views/Recruiter_Applications_Screen.dart';

import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';

class RecruiterTotalJobPosts extends StatelessWidget {
  TextEditingController seController = TextEditingController();

  RecruiterTotalJobPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// APP BAR
        appBar: buildCustomAppBar(titleText: "LOGO"),

        /// BODY
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.only(right: 24.0, top: 7.0, left: 24.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Jobs Posted",
                        style: mTextStyle32(mColor: Colors.black),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 320,
                            child: customSearchBar(
                                controller: seController, hint: "Search "),
                          ),
                          Spacer(),
                          InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                  "assets/Icons/settings-sliders 1.svg"))
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TotalJobPostsCard(
                        heading: "Digital Marketing Executive",
                        subHeading:
                            "Last date to receive application is 27/04/2025.",
                        status: "Active",
                        nApplications: "(130)",
                        buttonTitle: "View Application",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TotalJobPostsCard(
                          heading: "Graphic Designer",
                          subHeading: "Last date to apply was 22/04/2025",
                          status: "Closed",
                          buttonTitle: "View Application",
                          nApplications: "(70)")
                    ]))));
  }
}

/// Total job posts container
class TotalJobPostsCard extends StatelessWidget {
  final String heading;
  final String? subHeading;
  final String status;
  final String nApplications;
  final String buttonTitle;

  const TotalJobPostsCard(
      {super.key,
      required this.heading,
      this.subHeading,
      required this.status,
      required this.nApplications,
      required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    bool isActive = status == "Active";

    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(heading,
                    style: mTextStyle12(mFontWeight: FontWeight.w600)),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Icon(Icons.more_horiz),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              subHeading ?? "",
              style: TextStyle(
                fontSize: 11,
                color: AppColors.blueTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 26,
                  child: greyContainer(
                    text: status,
                    bgColor: isActive
                        ? const Color(0xff1DB32F)
                        : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(width: 15),
                numSeenContainer(nSeen: 7500),
                const Spacer(),
                ViewAppContainer(
                  bgColor: TColors.secondary,
                  textColor: Colors.white,
                  title: buttonTitle,
                  nApplications: nApplications,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecruiterApplicationsScreen(
                                postName: heading)));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// Widget ViewApplication Container
class ViewAppContainer extends StatelessWidget {
  final String title;
  final String? nApplications;
  VoidCallback onTap;
  Color bgColor;
  Color textColor;

  ViewAppContainer(
      {super.key,
      required this.title,
      this.nApplications,
      required this.onTap,
      required this.bgColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: mTextStyle14(mColor: textColor),
            ),
            // const SizedBox(width: 3),
            Text(
              nApplications ?? "",
              style: mTextStyle14(mColor: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

/// Grey number of views container
Widget numSeenContainer({required int nSeen}) {
  return Container(
    width: 80,
    height: 26,
    decoration: BoxDecoration(
        color: Color(0xffEFF0F6), borderRadius: BorderRadius.circular(26)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/Icons/fi-rr-eye.svg",
          height: 12,
          width: 12,
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          nSeen.toString(),
          style: TextStyle(
              fontSize: 11,
              color: AppColors.textSize12Color,
              fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}

Widget customSearchBar(
    {required TextEditingController controller, required String hint}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
        suffixIcon: Icon(Icons.search, color: Colors.grey),
      ),
    ),
  );
}
