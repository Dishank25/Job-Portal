import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/views/signup_as_anyone_view.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/my_profile_bloc/my_profile_event.dart';
import '../../../../../ui_helper/ui_helper.dart';
import '../../../../../widgets/widgets.dart';

class UserEducationApprovalScreen extends StatefulWidget {
  const UserEducationApprovalScreen({super.key});

  @override
  State<UserEducationApprovalScreen> createState() =>
      _UserEducationApprovalScreenState();
}

class _UserEducationApprovalScreenState
    extends State<UserEducationApprovalScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController searchCourseController = TextEditingController();
  List<String> addedEducationLevels = [];
  List<EducationCardData> educationControllers = [];

  List<Map<String, dynamic>> createEducationMap() {
    return educationControllers.map((edu) {
      return {
        "level": edu.level,
        "schoolOrCollege": edu.schoolOrCollegeController.text.trim(),
        "board_or_university": edu.boardOrUniversityController.text.trim(),
        "start_year": edu.startYearController.text.trim(),
        "end_year": edu.endYearController.text.trim(),
        "percentage_or_cgpa": edu.percentageOrCgpaController.text.trim(),
      };
    }).toList();
  }

  void addEducationEntry(String level) {
    setState(() {
      addedEducationLevels.add(level);
      educationControllers.add(EducationCardData(
        level: level,
        schoolOrCollegeController: TextEditingController(),
        boardOrUniversityController: TextEditingController(),
        startYearController: TextEditingController(),
        endYearController: TextEditingController(),
        percentageOrCgpaController: TextEditingController(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Education",
                  style: mTextStyle32(mColor: Colors.black),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: searchCourseController,
                  hintText:
                      "Select your education level (e.g. 10th, 12th, B.Tech)",
                  suffixIcon: Icons.search,
                  fillColor: Colors.white,
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    final level = searchCourseController.text.trim();
                    if (level.isNotEmpty &&
                        !addedEducationLevels.contains(level)) {
                      addEducationEntry(level);
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.add, color: Colors.blue),
                      Text("Add education",
                          style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: educationControllers.length,
                  itemBuilder: (context, index) {
                    // return Card(
                    //   margin: const EdgeInsets.only(bottom: 16),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(12),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Text(
                    //               edu.level,
                    //               style: const TextStyle(
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //             const Spacer(),
                    //             IconButton(
                    //               onPressed: () {
                    //                 setState(() {
                    //                   addedEducationLevels.remove(edu.level);
                    //                   educationControllers.removeAt(index);
                    //                 });
                    //               },
                    //               icon: const Icon(Icons.close,
                    //                   color: Colors.red),
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(height: 8),
                    //         CustomTextField(
                    //           controller: edu.schoolOrCollegeController,
                    //           hintText: "School/College",
                    //           fillColor: Colors.white,
                    //         ),
                    //         const SizedBox(height: 8),
                    //         CustomTextField(
                    //           controller: edu.boardOrUniversityController,
                    //           hintText: "Board/University",
                    //           fillColor: Colors.white,
                    //         ),
                    //         const SizedBox(height: 8),
                    //         Row(
                    //           children: [
                    //             Expanded(
                    //               child: CustomTextField(
                    //                 controller: edu.startYearController,
                    //                 hintText: "Start Year",
                    //                 fillColor: Colors.white,
                    //               ),
                    //             ),
                    //             const SizedBox(width: 12),
                    //             Expanded(
                    //               child: CustomTextField(
                    //                 controller: edu.endYearController,
                    //                 hintText: "End Year",
                    //                 fillColor: Colors.white,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(height: 8),
                    //         CustomTextField(
                    //           controller: edu.percentageOrCgpaController,
                    //           hintText: "Percentage/CGPA",
                    //           fillColor: Colors.white,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );

                    final edu = educationControllers[index];

                    return EducationFillingCard(
                      courseNameText: edu.level,
                      college_nameController: edu.schoolOrCollegeController,
                      specializationController: edu.boardOrUniversityController,
                      startYearController: edu.startYearController,
                      endYearController: edu.endYearController,
                      onTapCross: () {
                        setState(() {
                          addedEducationLevels.remove(edu.level);
                          educationControllers.removeAt(index);
                        });
                      },
                    );
                  },
                ),
                Center(
                  child: SizedBox(
                    width: 150,
                    child: nextButton(
                      title: "Save Changes",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final list = createEducationMap();
                          final map = {'educations': list};
                          final user_id = sl<PreferencesManager>().getuser_id();
                          context
                              .read<MyProfileBloc>()
                              .add(LoadUpdateProfile(user_id ?? '2', map));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please complete all fields")),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EducationFillingCard extends StatefulWidget {
  final String courseNameText;
  final TextEditingController college_nameController;
  final TextEditingController specializationController;
  final TextEditingController startYearController;
  final TextEditingController endYearController;
  final VoidCallback onTapCross;
  final String? Function(String?)? validator;

  const EducationFillingCard({
    super.key,
    required this.courseNameText,
    required this.college_nameController,
    required this.specializationController,
    required this.startYearController,
    required this.endYearController,
    required this.onTapCross,
    this.validator,
  });

  @override
  State<EducationFillingCard> createState() => _EducationFillingCardState();
}

class _EducationFillingCardState extends State<EducationFillingCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(29, 179, 47, 0.1),
            border: Border.all(color: const Color.fromRGBO(29, 179, 47, 0.2)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Course + Upload/Edit
                Row(
                  children: [
                    courseName(
                      name: widget.courseNameText,
                      bgColor: const Color(0xff1961F3),
                      mIcon: Icons.cancel,
                      onTap: widget.onTapCross,
                    ),
                    const Spacer(),
                    courseName(
                      name: "View/Edit Certificate",
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // College Name
                Text("College Name", style: mTextStyle12()),
                CustomTextField(
                  controller: widget.college_nameController,
                  hintText: "Eg. Delhi Technological University",
                  fillColor: Colors.white,
                  validator: widget.validator,
                ),

                const SizedBox(height: 10),

                // Specialization
                Text("Specialization", style: mTextStyle12()),
                CustomTextField(
                  controller: widget.specializationController,
                  hintText: "Eg. Computer Science",
                  fillColor: Colors.white,
                  validator: widget.validator,
                ),

                const SizedBox(height: 10),

                // Start Year & End Year Row
                Row(
                  children: [
                    Text("Start Year", style: mTextStyle12()),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 110.0),
                      child: Text("End Year", style: mTextStyle12()),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: DatePickerField(
                        controller: widget.startYearController,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: DatePickerField(
                        controller: widget.endYearController,
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class EducationCardData {
  String level;
  TextEditingController schoolOrCollegeController;
  TextEditingController boardOrUniversityController;
  TextEditingController startYearController;
  TextEditingController endYearController;
  TextEditingController percentageOrCgpaController;

  EducationCardData({
    required this.level,
    required this.schoolOrCollegeController,
    required this.boardOrUniversityController,
    required this.startYearController,
    required this.endYearController,
    required this.percentageOrCgpaController,
  });
}
