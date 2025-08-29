import 'dart:developer' as developer show log;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/utils/constants/constants.dart';
import 'package:job_portal/utils/constants/image_string.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/views/bottom_nav_bar/student_bottom_nav_bar.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_apply_bloc/job_apply_bloc.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_apply_bloc/job_apply_event.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_apply_bloc/job_apply_state.dart';
import 'package:job_portal/views/user_profile/presentation/views/User_Notifications_Screen.dart';
import 'package:job_portal/views/user_profile/presentation/views/User_messages_screen.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_details_bloc/job_details_bloc.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_details_bloc/job_details_event.dart';
import 'package:job_portal/views/job_related/presentation/bloc/job_details_bloc/job_details_state.dart';
import 'package:job_portal/views/user_profile/presentation/views/user_authentication_and_approval_screens/user_auth_view.dart';
import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatefulWidget {
  final VoidCallback? onCallBack;
  final VoidCallback? onShowCompanyJobs;
  final int? job_id;
  const JobDetailsScreen(
      {super.key, this.onCallBack, this.onShowCompanyJobs, this.job_id});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  String messageWhileLoadingDetails = '';
  bool areDetailsLoaded = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final map = {'job_id': widget.job_id.toString()};
    context.read<JobDetailsBloc>().add(LoadJobDetail(map));
  }

  void showCustomSnackBar(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.4),
                  offset: Offset(0, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Red Circle Icon with white "X"
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.red)),
                  padding: const EdgeInsets.all(2),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Aadhaar not verified. Please verify to proceed with your job application.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: Handle Aadhaar verification tap
                          // overlayEntry.remove();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserAuthScreen()));
                        },
                        child: Text(
                          "Tap to verify now.",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.secondary,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Auto-remove after 5 seconds
    Future.delayed(Duration(seconds: 15), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          ImageString.jobPortalLogo,
          height: 30,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MessagesScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Icons/message_icon.svg"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Icons/notifications_icon.svg"),
            ),
          ),
        ],
      ),
      // appBar: buildCustomAppBar(titleText: "LOGO"),

      /// BODY CONTENT
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
          child: BlocBuilder<JobDetailsBloc, JobDetailsState>(
            builder: (context, state) {
              if (state is JobDetailsLoaded) {
                final data = state.jobDetailsEntity;
                // developer.log("Details of job data : ${data.jobProfile}");
                areDetailsLoaded = true;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 93,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xffEDF1F3), width: 1.0),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: SizedBox(
                                height: 60,
                                width:
                                    60, // make this square to avoid oval distortion
                                // color: Colors.grey[
                                //     200], // optional: placeholder background
                                // child: Image.network(
                                //   ImageString.dummyImageUrl,
                                //   fit: BoxFit
                                //       .cover, // Ensures the image fills the box correctly
                                // ),
                                child: Image.asset(
                                  ImageString.placeHolderImage,
                                  color: Colors.grey[300],
                                  fit: BoxFit
                                      .cover, // Ensures the image fills the box correctly
                                ),
                              ),
                            ),
                          ),

                          // SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // "Digital Marketing Executive",
                                  data.jobProfile,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  data.company_name,
                                  style: mTextStyle14(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    greyContainer(
                                        text: 'Actively Hiring',
                                        bgColor: TColors.secondary),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    greyContainer(
                                        text: "2 weeks ago",
                                        bgColor: Color(0xffEFF0F6))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     jobRelatedOptions(
                    //         title: "INR ${data.stipend_min}-${data.stipend_max}"),
                    //     jobRelatedOptions(title: data.candidate_preferences),
                    //     jobRelatedOptions(
                    //         title: data.cityChoice ?? 'City Choice'),
                    //     jobRelatedOptions(title: "45 Applicants")
                    //   ],
                    // ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        jobRelatedOptions(
                            // title: "INR ${data.stipend_min}-${data.stipend_max}"
                            title: "INR ${data.salary}"),
                        jobRelatedOptions(
                            title: data.candidate_preferences ??
                                'Candidate Preference'),
                        jobRelatedOptions(
                            title: data.cityChoice ?? 'City Choice'),
                        jobRelatedOptions(title: "45 Applicants"),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Your role",
                      style: mTextStyle14(mFontWeight: FontWeight.w600),
                    ),
                    Text("• ${data.job_description}"),
                    SizedBox(
                      height: 11,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("About ${data.company_name}",
                              style:
                                  mTextStyle14(mFontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                              onTap: () {
                                if (widget.onShowCompanyJobs != null) {
                                  widget.onShowCompanyJobs!();
                                }
                              },
                              child: Text(
                                  "More Job openings at ${data.company_name}",
                                  style: mTextStyle14().copyWith(
                                    color: AppColors.blueTextColor,
                                  ))),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(data.aboutCompany),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // InkWell(
                    //     onTap: () {
                    //       showSnackbar("Apply tapped", context);
                    //       // Navigator.pushReplacement(
                    //       //     context,
                    //       //     MaterialPageRoute(
                    //       //         builder: (context) =>
                    //       //             Student_Bottom_Nav_bar()));
                    //     },
                    //     child: commonRedContainer(text: "Apply")),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              } else if (state is JobDetailsLoading) {
                messageWhileLoadingDetails =
                    'Hold tight we are loading details for you...';

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(messageWhileLoadingDetails),
                    ],
                  ),
                );
              } else if (state is JobDetailsError) {
                messageWhileLoadingDetails =
                    'Oops. There was some error loading details.';
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(messageWhileLoadingDetails),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text('Unhandled state : $state'),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocListener<JobApplyBloc, JobApplyState>(
          listener: (context, state) {
            if (state is JobApplyLoading) {
              developer.log('Job apply loading');
            } else if (state is JobApplyLoaded) {
              developer.log('Job apply loaded');
              // showSnackbar(state.jobApplyEntity.message, context);
              showCustomSnackBar(context);
              Navigator.pop(context);
            } else if (state is JobApplyError) {
              // showSnackbar(
              //     "Aadhaar is not verified. Please verify Aadhaar before applying.",
              //     context);
              showCustomSnackBar(context);
              developer.log('Job apply error');
            }
          },
          child: InkWell(
              onTap: () {
                if (areDetailsLoaded) {
                  context
                      .read<JobApplyBloc>()
                      .add(LoadJobApply(widget.job_id.toString()));
                }
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text("Applied Successfully")));
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Student_Bottom_Nav_bar()));
              },
              child: commonRedContainer(text: "Apply")),
        ),
      ),
    );
  }
}

Widget greyContainer(
    {required String text,
    required Color bgColor,
    Color? txtClr,
    bool? border}) {
  // developer.log(text);
  return Container(
    width: 100,
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(90),
        border: border != null
            ? Border.all(color: const Color.fromARGB(255, 225, 225, 225))
            : null),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        color: txtClr ??
            (bgColor == const Color(0xffEFF0F6)
                ? const Color(0xff6C7278)
                : Colors.white),
      ),
    ),
  );
}

// Widget jobRelatedOptions({required String title}) {
//   return Container(
//     width: 90,
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(26),
//         border: Border.all(color: const Color(0xffEFF0F6), width: 1.0)),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Center(
//         child: Text(
//           title,
//           overflow: TextOverflow.ellipsis,
//           style: const TextStyle(
//             fontSize: 11,
//             color: Color(0xff6C7278),
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//     ),
//   );
// }

Widget jobRelatedOptions({required String title}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(26),
      border: Border.all(color: const Color(0xffEFF0F6), width: 1.0),
    ),
    child: Text(
      title,
      softWrap: true,
      style: const TextStyle(
        fontSize: 11,
        color: Color(0xff6C7278),
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
