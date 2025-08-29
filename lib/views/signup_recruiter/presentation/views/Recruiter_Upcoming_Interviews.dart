import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/views/signup_recruiter/presentation/views/Recruiter_pipeline_candidates.dart';

import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import 'package:job_portal/views/recruiter_job_post/presentation/view/Recruiter_total_job_posts.dart';

class RecruiterUpcomingInterviews extends StatelessWidget {
  TextEditingController searController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildCustomAppBar(titleText: "LOGO"),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.only(right: 24.0, top: 7.0, left: 24.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upcoming Interviews",
                        style: mTextStyle32(mColor: Colors.black),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            controller: searController,
                            hintText: "Search by name, role or keyword...",
                            fillColor: Colors.white,
                            suffixIcon: Icons.search,
                            onSuffixTap: () {},
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                  "assets/Icons/settings-sliders 1.svg")),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          optionContainer(
                              title: "Today",
                              textColor: Color(0xff6C7278),
                              bgColor: Colors.white,
                              nApplications: "(2)"),
                          optionContainer(
                              title: "This Week",
                              textColor: Color(0xff6C7278),
                              bgColor: Colors.white,
                              nApplications: "(4)"),
                          optionContainer(
                              title: "Custom",
                              textColor: Color(0xff6C7278),
                              bgColor: Colors.white,
                              nApplications: ""),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InterviewCard(
                        viewContainerText: "Join Now",
                        applicantName: "Sanya Arora",
                        postName: "UX/UI Designer",
                        Mode: "Zoom",
                        interview_date: "05/05/2025",
                        interview_time: "10:30 a.m",
                        status: "Confirmed",
                        tColor: Color(0xff00BB5E),
                        bgColor: Color(0xffE0F8EB),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InterviewCard(
                        viewContainerText: "View Details",
                        applicantName: "Shipra Ahuja",
                        postName: "UX/UI Designer",
                        Mode: "Zoom",
                        interview_date: "Pending",
                        interview_time: "",
                        status: "Reschedule pending",
                        tColor: Color(0xffFFA30F),
                        bgColor: Color(0xffFFF6E4),
                      ),
                    ]))));
  }
}

class InterviewCard extends StatelessWidget {
  String applicantName;
  String postName;
  String Mode;
  String interview_date;
  String interview_time;
  String status;
  Color bgColor;
  Color tColor;
  String viewContainerText;

  InterviewCard(
      {required this.applicantName,
      required this.postName,
      required this.Mode,
      required this.interview_date,
      required this.status,
      required this.bgColor,
      required this.tColor,
      required this.interview_time,
      required this.viewContainerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
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
                  style: mTextStyle14(mFontWeight: FontWeight.w600)),
              const Spacer(),
              optionContainer(
                  title: status, textColor: tColor, bgColor: bgColor),
              Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            postName,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Mode: $Mode",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                " $interview_date  $interview_time ",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 160,
                child: ViewAppContainer(
                  title: viewContainerText,
                  bgColor: viewContainerText == "Join Now"
                      ? AppColors.blueTextColor
                      : TColors.secondary,
                  textColor: Colors.white,
                  onTap: () {
                    /// Handle
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
