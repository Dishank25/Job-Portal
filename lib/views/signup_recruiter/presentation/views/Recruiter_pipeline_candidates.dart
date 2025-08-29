import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/views/recruiter_application/presentation/view/Recruiter_Applications_Screen.dart';

import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import 'package:job_portal/views/recruiter_job_post/presentation/view/Recruiter_total_job_posts.dart';

class RecruiterPipelineCandidates extends StatelessWidget {
  TextEditingController fdController = TextEditingController();

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
                        "Pipeline Candidates",
                        style: mTextStyle32(mColor: Colors.black),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            controller: fdController,
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
                      // applied, screening, interview, offered
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          optionContainer(
                              title: "Applied",
                              textColor: Color(0xff6C7278),
                              bgColor: Colors.white,
                              nApplications: "(3)",
                              onTap: () {}),
                          optionContainer(
                              title: "Screening",
                              textColor: Color(0xff6C7278),
                              bgColor: Colors.white,
                              nApplications: "(4)"),
                          optionContainer(
                              title: "Interview",
                              textColor: Color(0xff6C7278),
                              bgColor: Colors.white,
                              nApplications: "(3)"),
                          optionContainer(
                              title: "Offered",
                              textColor: Color(0xff6C7278),
                              bgColor: Colors.white,
                              nApplications: "(1)"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Hired
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: optionContainer(
                            title: "Hired",
                            textColor: AppColors.blueTextColor,
                            bgColor: Colors.blue.shade100,
                            nApplications: "(2)"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppReceivedCard(
                          applicantName: "Sonali Ahuja",
                          postName: "UX Designer",
                          total_exp: "Fresher",
                          appliedDate: "3",
                          status: "Actively Hiring",
                          bgColor: Color(0xffFFF6E4),
                          tColor: Color(0xffFFA30F)),
                      SizedBox(
                        height: 20,
                      ),
                      AppReceivedCard(
                          applicantName: "Shanaya Arora",
                          postName: "UX Designer",
                          total_exp: "3 years",
                          appliedDate: "3",
                          status: "Hired",
                          bgColor: Color(0xffE0F8EB),
                          tColor: Color(0xff00BC5E)),
                    ]))));
  }
}

/// Row widget with options

Widget optionContainer({
  required String title,
  String? nApplications,
  required Color textColor,
  required Color bgColor,
  VoidCallback? onTap,
}) {
  final bool isBgWhite = bgColor == Colors.white;

  return InkWell(
    onTap: onTap,
    //borderRadius: BorderRadius.circular(26),
    child: Container(
      height: 26,
      // width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        border: Border.all(width: 1, color: Colors.grey.shade300),
        color: bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isBgWhite ? const Color(0xff6C7278) : textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (nApplications != null)
            Text(
              " $nApplications",
              style: TextStyle(
                fontSize: 12,
                color: isBgWhite ? const Color(0xff6C7278) : textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    ),
  );
}

/// Pipeline Candidates Container
class AppReceivedCard extends StatelessWidget {
  String applicantName;
  String postName;
  String total_exp;
  String appliedDate;
  String status;
  Color bgColor;
  Color tColor;

  AppReceivedCard(
      {required this.applicantName,
      required this.postName,
      required this.total_exp,
      required this.appliedDate,
      required this.status,
      required this.bgColor,
      required this.tColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      /* height: 118,
      width: double.infinity,*/
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
          const SizedBox(height: 4),
          Text(
            postName,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Total Work Experience: $total_exp",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          //  const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Applied $appliedDate days ago",
                style: TextStyle(
                  fontSize: 11,
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
