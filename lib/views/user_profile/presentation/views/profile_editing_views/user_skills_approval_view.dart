import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer show log;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/ui_helper/ui_helper.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/utils/upload_file_get_url/presentation/bloc/upload_file_bloc.dart';
import 'package:job_portal/utils/upload_file_get_url/presentation/bloc/upload_file_event.dart';
import 'package:job_portal/utils/upload_file_get_url/presentation/bloc/upload_file_state.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/skill_bloc/skill_bloc.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/skill_bloc/skill_event.dart'
    as se;
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/skill_bloc/skill_state.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:job_portal/views/user_profile/presentation/bloc/my_profile_bloc/my_profile_event.dart';
import 'package:job_portal/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../detailed_signup_student/presentation/bloc/skill_bloc/skill_event.dart'; // for MediaType

class UserSkillsApprovalScreen extends StatefulWidget {
  const UserSkillsApprovalScreen({super.key});

  @override
  State<UserSkillsApprovalScreen> createState() =>
      _UserSkillsApprovalScreenState();
}

class _UserSkillsApprovalScreenState extends State<UserSkillsApprovalScreen> {
   TextEditingController skillSearchController = TextEditingController();
   Key _autoCompKey = UniqueKey();
   List<String> domains = [];
   List<String> selectedSkills = [];
   @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   context.read<SkillBloc>().add(LoadDomains());
  // }

  TextEditingController skillsSearchController = TextEditingController();
  String? token;
  String? selectedDomain;

  final _prefs = sl<PreferencesManager>();

  final _formKey = GlobalKey<FormState>();
  UniqueKey _autoCompleteKey = UniqueKey();

  /// Domain Skills Drop Down
  final LayerLink _domainLink = LayerLink();
  final GlobalKey _domainFieldKey = GlobalKey();
  OverlayEntry? _domainOverlayEntry;

  List<String> allDomains = [];
  List<String> tempSelectedDomains = [];
  List<String> selectedDomains = [];

  var skillParams = {};
  Map<String, List<String>> subSkillsMap = {};
  Map<String, List<String>> selectedSubSkillsPerDomain = {};
  final Map<String, TextEditingController> courseCollegeControllers = {};
  Map<String, dynamic> certificateImages = {};

  Map<String, dynamic> finalSkillData = {};

  void _showDomainDropdown(
      BuildContext context, TextEditingController controller) {
    final renderBox =
        _domainFieldKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    // context.read<DomainBloc>().add(FetchDomains());

    _domainOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height,
        child: CompositedTransformFollower(
          link: _domainLink,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_domainOverlayEntry!);
  }

  @override
  void dispose() {
    // Ensure any active overlay is removed to prevent _dependents assertion error
    _domainOverlayEntry?.remove();
    _domainOverlayEntry = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _loadToken();

    final skills = _prefs.getSkillParams();
    if (skills != null) {
      skillParams = jsonDecode(skills);
      developer.log('These are skill params : $skillParams');

      setState(() {
        selectedDomains =
        List<String>.from(skillParams['selectedDomains'] ?? []);

        selectedSubSkillsPerDomain =
            (skillParams['selectedSubSkillsPerDomain'] as Map<String, dynamic>)
                .map(
                  (key, value) => MapEntry(
                key,
                List<String>.from(value),
              ),
            );
      });

      //  Re-fetch sub-skills for each cached domain
      for (final domain in selectedDomains) {
        context.read<SkillBloc>().add(se.LoadSubSkills(domain));
      }
    }

  }

  // Create a param for skills selected. to preserve state when going back and fourth.
  Future<void> cacheSkills() async {
    var map = {
      'selectedDomains': selectedDomains,
      'selectedSubSkillsPerDomain': selectedSubSkillsPerDomain
    };

    await _prefs.setSkillParams(map);
  }

  int iterator = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final bloc = context.read<SkillBloc>();
    bloc.add(const se.LoadDomains());

    // context.read<SkillBloc>().add(LoadSubSkills(tempSelectedDomains.first));

    super.didChangeDependencies();
  }

  void _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(""),
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
        leading: IconButton(
            onPressed: () async {
              await cacheSkills();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 42,
                  width: double.infinity,
                  child: Text(
                    "Your Skills",
                    style: mTextStyle32(mColor: Color(0xff1A1C1E)),
                  ),
                ),
                mSpacer(mHeight: 25.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mSpacer(mHeight: 8.0),
                    BlocListener<SkillBloc, SkillState>(

                      listener: (context, state) {
                        if (state is SkillStateDomainLoaded) {
                          setState(() {
                            allDomains = state.domainAllResponse.domains;
                          });
                        } else if (state is SubSkillLoaded) {
                          final data = state.subSkillResponse;
                          final domain = state.domain;

                          if (!subSkillsMap.containsKey(domain)) {
                            setState(() {
                              subSkillsMap[domain] = data.skills;
                            });
                          }
                        } else if (state is SkillCertificatesLoaded) {
                          final certificates = state.skillCertificates;

                          setState(() {
                            certificateImages = certificates;
                          });

                          developer.log('Certificates : $certificates');
                        } else if (state is SkillCertificateLoading) {
                          developer.log('Picking Certificate.');
                        }
                      },
                      child: Container(
                        key: _autoCompleteKey,
                        child: CustomAutocomplete(
                          options: allDomains,
                          label: 'Select Area of interest',
                          onSelected: (value) {
                            if (!selectedDomains.contains(value)) {
                              context
                                  .read<SkillBloc>()
                                  .add(se.LoadSubSkills(value));
                              setState(() {
                                selectedDomains.add(value);
                                _autoCompleteKey = UniqueKey();
                              });
                            } else {
                              showSnackbar('Skill already selected.', context);
                              setState(() {
                                _autoCompleteKey = UniqueKey();
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    mSpacer(mHeight: 16.0),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: selectedDomains.length,
                      itemBuilder: (context, index) {
                        final domain = selectedDomains[index];
                        final subSkills = subSkillsMap[domain] ?? [];
                        final selectedSkills =
                            selectedSubSkillsPerDomain[domain] ?? [];

                        // Initialize the controller if not already present
                        courseCollegeControllers.putIfAbsent(
                            domain, () => TextEditingController());

                        return Column(
                          children: [
                            preferenceContainer(

                              cName: domain,
                              fileName:
                                  certificateImages[domain]?.files.first.name,
                              onTap: () {},
                              subSkills: subSkillsMap[domain] ?? [],
                              selectedSubSkills: selectedSkills,
                              onSkillTap: (skill) {
                                setState(() {
                                  final selected =
                                      selectedSubSkillsPerDomain[domain] ?? [];
                                  if (selected.contains(skill)) {
                                    selected.remove(skill);
                                  } else {
                                    selected.add(skill);
                                  }
                                  selectedSubSkillsPerDomain[domain] =
                                      List.from(selected);
                                });
                              },
                              courseCollegeController:
                                  courseCollegeControllers[domain]!,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter the details';
                                }
                                return null;
                              },
                              onUploadCertificateTap: () {
                                if (domain.isNotEmpty) {
                                  final skill = domain;
                                  developer.log('Skill : $skill');
                                  if (skill != null) {
                                    context.read<SkillBloc>().add(
                                        se.PickCertificate(skillName: skill));
                                  } else {
                                    // show snackbar or dialog to tell user to select only one
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Please select only one skill to upload certificate.')),
                                    );
                                  }
                                }
                              },
                              onCrossTap: () {
                                setState(() {
                                  courseCollegeControllers.remove(domain);
                                  // remove the certificate for this skill too
                                  context.read<SkillBloc>().add(
                                      se.RemoveCertificate(skillName: domain));
                                  selectedSubSkillsPerDomain.remove(domain);
                                  selectedDomains.removeAt(index);
                                });
                              },
                            ),
                            mSpacer(),
                          ],
                        );
                      },
                    ),
                    mSpacer(mHeight: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // nextButton(
                        //   title: "Next",
                        //   onTap: () async {
                        //     if (_formKey.currentState!.validate()) {
                        //       final skillData = await createParamsForSkill();
                        //       context
                        //           .read<SkillBloc>()
                        //           .add(SubmitSkills(skillData));
                        //       _prefs.clear(PreferencesManager.SKILL_PARAMS);
                        //     } else {
                        //       showSnackbar(
                        //           'Please enter all the details', context);
                        //     }
                        //   },
                        // ),
                        BlocListener<UploadFileBloc, UploadFileState>(
                          listener: (context, state) {
                            if (state is UploadFileLoaded) {
                              final urls = state.uploadFileEntity;

                              finalSkillData = createSkillList(urls.url);

                              final _prefs = sl<PreferencesManager>();
                              final user_id = _prefs.getuser_id();
                              context.read<MyProfileBloc>().add(
                                  LoadUpdateProfile(
                                      user_id ?? '6', finalSkillData));
                            } else if (state is UploadFileLoading) {
                              developer.log(
                                  'Wait we are uploading your certificates.');
                            } else if (state is UploadFileError) {
                              developer
                                  .log('Error while uploading certificates.');
                            }
                          },
                          child: SizedBox(),
                        ),
                        nextButton(
                          title: "Save Changes",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              // final skillList = await createSkillList();
                              await uploadCertificates();

                              _prefs.clear(PreferencesManager.SKILL_PARAMS);
                            } else {
                              showSnackbar(
                                  'Please enter all the details', context);
                            }
                          },
                        ),
                      ],
                    ),
                    mSpacer(mHeight: 24.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadCertificates() async {
    // Step 2: Create FormData
    final formData = FormData();

    // Step 3: Attach certificate images with indexed keys
    // ignore: unused_local_variable
    int index = 0;
    for (var domain in certificateImages.keys) {
      final file = certificateImages[domain].files.first;
      if (file != null) {
        final fileName = file.path.split('/').last;
        formData.files.add(
          MapEntry(
            // 'certificate_image_$index',
            'certificateImage',
            await MultipartFile.fromFile(file.path, filename: fileName),
          ),
        );
        index++;
      }
    }

    context.read<UploadFileBloc>().add(LoadUploadFile(formData));

    developer.log(
        'For Data of skill\nfields : ${formData.fields}\nfiles : ${formData.files}');
  }

  Map<String, dynamic> createSkillList(List<dynamic> urls) {
    // Step 1: Construct skill list
    List<Map<String, dynamic>> skillList = [];

    for (int i = 0; i < selectedDomains.length; i++) {
      final skill = selectedDomains[i];
      final authority = courseCollegeControllers[skill]?.text ?? '';

      skillList.add({
        'skill_id': i + 1, // check this
        "skill": skill,
        "authority": authority,
      });
    }

    final map = {'skills': skillList, 'certificate_images': urls};

    developer.log('Skill map : $map');

    return map;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       backgroundColor: Colors.white,
  //       actions: [
  //         InkWell(
  //           onTap: () {},
  //           child: Padding(
  //             padding: const EdgeInsets.only(right: 20.0),
  //             child: SvgPicture.asset("assets/Icons/message_icon.svg"),
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {},
  //           child: Padding(
  //             padding: const EdgeInsets.only(right: 20.0),
  //             child: SvgPicture.asset("assets/Icons/notifications_icon.svg"),
  //           ),
  //         ),
  //       ],
  //     ),
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             BlocListener<SkillBloc, SkillState>(
  //               listener: (context, state) {
  //                 if (state is SkillStateDomainLoaded) {
  //                   final data = state.domainAllResponse;
  //                   setState(() {
  //                     domains = data.domains;
  //                   });
  //                   developer.log("Loaded domains");
  //                 } else if (state is SkillStateDomainError) {
  //                   developer.log("Error in loading domains");
  //                 } else if (state is SkillStateDomainLoading) {
  //                   developer.log("Loading domains");
  //                 }
  //               },
  //               child: SizedBox(),
  //             ),
  //             Text(
  //               "Your Skills",
  //               style: mTextStyle32(mColor: Colors.black),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Container(
  //               key: _autoCompKey,
  //               child: CustomAutocomplete(
  //                 options: domains,
  //                 label: "List Your Skills here...",
  //                 onSelected: (value) {
  //                   if (!selectedSkills.contains(value)) {
  //                     setState(() {
  //                       selectedSkills.add(value);
  //                       _autoCompKey = UniqueKey();
  //                     });
  //                   }
  //                 },
  //               ),
  //             ),
  //             SizedBox(
  //               height: 16,
  //             ),
  //             ListView.builder(
  //                 physics: const NeverScrollableScrollPhysics(),
  //                 shrinkWrap: true,
  //                 itemCount: selectedSkills.length,
  //                 itemBuilder: (context, index) {
  //                   final domain = selectedSkills[index];
  //                   final controller = TextEditingController();
  //                   return Column(
  //                     children: [
  //                       preferenceContainer(
  //                         cName: domain,
  //                         cIcon: Icons.cancel,
  //                         onTap: () {},
  //                         onCrossTap: () {
  //                           setState(() {
  //                             selectedSkills.removeAt(index);
  //                           });
  //                         },
  //                         courseCollegeController: controller,
  //                       ),
  //                       SizedBox(
  //                         height: 16,
  //                       ),
  //                     ],
  //                   );
  //                 }),
  //             const SizedBox(
  //               height: 24,
  //             ),
  //             BlocListener<MyProfileBloc, MyProfileState>(
  //               listener: (context, state) {
  //                 // TODO: implement listener
  //                 if (state is UpdateProfileLoaded) {
  //                   developer.log('Skills updated');
  //                   Navigator.pop(context);
  //                 } else if (state is UpdateProfileLoading) {
  //                   developer.log('Skills updating please wait');
  //                 } else if (state is UpdateProfileLoaded) {
  //                   developer.log(
  //                       'Encountered some issue while updating skills. Please try again');
  //                   showSnackbar(
  //                       'Encountered some issue while updating skills. Please try again',
  //                       context);
  //                 }
  //               },
  //               child: Center(
  //                 child: SizedBox(
  //                   width: 150,
  //                   child: nextButton(
  //                     title: "Save Changes",
  //                     onTap: () {
  //                       if (selectedSkills.isNotEmpty) {
  //                         final map = {'skills': selectedSkills};
  //                         final _prefs = sl<PreferencesManager>();
  //                         final user_id = _prefs.getuser_id();
  //                         context
  //                             .read<MyProfileBloc>()
  //                             .add(LoadUpdateProfile(user_id ?? '2', map));
  //                       } else {
  //                         showSnackbar("No skills selected", context);
  //                       }
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
