import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/views/job_related/presentation/views/job_details_view.dart';

import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import 'Recruiter_View_Full_Application_screen.dart';
import 'Recruiter_total_job_posts.dart';

class RecruiterApplicationsScreen extends StatefulWidget {
  String postName;
  RecruiterApplicationsScreen({super.key, required this.postName});

  @override
  State<RecruiterApplicationsScreen> createState() =>
      _RecruiterApplicationsScreenState();
}

class _RecruiterApplicationsScreenState
    extends State<RecruiterApplicationsScreen> {
  TextEditingController searchingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App bar
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "LOGO",
            style: TextStyle(
                fontSize: 20,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
                color: TColors.primary),
          ),
        ),

        /// Icons Row
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

      /// Body Part
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading name
              Text("Applications", style: mTextStyle32(mColor: Colors.black)),
              const SizedBox(height: 7),
              Text("${widget.postName} Internship"),
              const SizedBox(height: 25),

              /// Search Bar Row
              Row(
                children: [
                  Expanded(
                    child: customSearchBar(
                        controller: searchingController, hint: "Search"),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    child:
                        SvgPicture.asset("assets/Icons/settings-sliders 1.svg"),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// App Card
              AppReceivedCard(
                  applicantName: "Saloni",
                  Location: "Delhi",
                  total_exp: "5 months",
                  appliedDate: "3",
                  resumeMatch: "Moderate",
                  bgColor: Color(0xffFFF5E6),
                  tColor: Color(0xffFFAD29),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Recruiter_View_Full_Application_screen()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

///  Applications Received Card
class AppReceivedCard extends StatelessWidget {
  String applicantName;
  String Location;
  String total_exp;
  String appliedDate;
  String resumeMatch;
  Color bgColor;
  Color tColor;
  VoidCallback onTap;

  AppReceivedCard(
      {super.key,
      required this.applicantName,
      required this.Location,
      required this.total_exp,
      required this.appliedDate,
      required this.resumeMatch,
      required this.bgColor,
      required this.tColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Name + Resume Match
          Row(
            children: [
              Text(applicantName,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const Spacer(),
              colorContainer(
                  resumeMatch: resumeMatch, bgColor: bgColor, tColor: tColor)
            ],
          ),
          const SizedBox(height: 4),
          Text(
            Location,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Total Work Experience: $total_exp",
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Applied $appliedDate days ago",
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 160,
                child: ViewAppContainer(
                    bgColor: TColors.secondary,
                    textColor: Colors.white,
                    title: "View Full Application",
                    onTap: onTap),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Color containers of peach, red and green color

Widget colorContainer(
    {required String resumeMatch,
    required Color bgColor,
    required Color tColor}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tColor)),
    child: Text(
      "Resume Match: $resumeMatch",
      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400, color: tColor),
    ),
  );
}
