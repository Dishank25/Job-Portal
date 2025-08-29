import 'dart:convert';
import 'dart:developer' as developer show log;

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/utils/constants/image_string.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/skill_bloc/skill_bloc.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/skill_bloc/skill_event.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/skill_bloc/skill_state.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/views/signup_your_preferences_view.dart';
import 'package:job_portal/ui_helper/ui_helper.dart';
import 'package:job_portal/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPageYourSkills extends StatefulWidget {
  Map<String, dynamic> params;
  SignupPageYourSkills({super.key, required this.params});

  @override
  State<SignupPageYourSkills> createState() => _SignupPageYourSkillsState();
}

class _SignupPageYourSkillsState extends State<SignupPageYourSkills> {
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

  void _showDomainDropdown(
    BuildContext context,
    TextEditingController controller,
  ) {
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
          child: Material(elevation: 4, borderRadius: BorderRadius.circular(8)),
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
        selectedDomains = List<String>.from(
          skillParams['selectedDomains'] ?? [],
        );
        // for (int i = 0; i < selectedDomains.length; i++) {
        //   context.read<SkillBloc>().add(LoadSubSkills(selectedDomains[i]));
        // }
        // to call subskills
        tempSelectedDomains = selectedDomains;

        selectedSubSkillsPerDomain =
            (skillParams['selectedSubSkillsPerDomain'] as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, List<String>.from(value)));
      });
    }
  }

  // Create a param for skills selected. to preserve state when going back and fourth.
  Future<void> cacheSkills() async {
    var map = {
      'selectedDomains': selectedDomains,
      'selectedSubSkillsPerDomain': selectedSubSkillsPerDomain,
    };

    await _prefs.setSkillParams(map);
  }

  int iterator = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final bloc = context.read<SkillBloc>();
    bloc.add(const LoadDomains());

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
    // if (token == null) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

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
                  builder: (context) => SignupPageYourPreferences(params: {}),
                ),
              );
            },
            icon: const Icon(Icons.double_arrow),
          ),
        ],
        leading: IconButton(
          onPressed: () async {
            await cacheSkills();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SvgPicture.asset(
                    // ImageString.progressBar1,
                    ImageString.jobPortalLogo,
                    height: 30,
                    // width: 40,
                    fit: BoxFit.contain,
                    allowDrawingOutsideViewBox: true, // optional
                  ),
                  // child: Image.asset(ImageString.pngLogo),
                ),
                mSpacer17(),
                SizedBox(
                  height: 42,
                  width: double.infinity,
                  child: Text(
                    "Your Skills",
                    style: mTextStyle32(mColor: Color(0xff1A1C1E)),
                  ),
                ),
                Text(
                  "Help us match you with the best career opportunities",
                  style: mTextStyle12(),
                ),
                mSpacer(mHeight: 25.0),
                SvgPicture.asset(ImageString.progressBar2),
                const SizedBox(height: 3),
                mSpacer(mHeight: 25.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Areas of Interest", style: mTextStyle14()),
                    mSpacer(mHeight: 8.0),
                    BlocListener<SkillBloc, SkillState>(
                      listener: (context, state) {
                        if (state is SkillStateDomainLoaded) {
                          // if ()
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
                              context.read<SkillBloc>().add(
                                    LoadSubSkills(value),
                                  );
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
                          domain,
                          () => TextEditingController(),
                        );

                        return Column(
                          children: [
                            preferenceContainer(
                              cName: domain,
                              fileName:
                                  certificateImages[domain]?.files.first.name,
                              onTap: () {},
                              subSkills: subSkills,
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
                                  context.read<SkillBloc>().add(
                                        PickCertificate(skillName: skill),
                                      );
                                }
                              },
                              onCrossTap: () {
                                setState(() {
                                  courseCollegeControllers.remove(domain);
                                  // remove the certificate for this skill too
                                  context.read<SkillBloc>().add(
                                        RemoveCertificate(skillName: domain),
                                      );
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
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color(0xff6C7278)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.arrow_back, size: 16),
                                Text("Back", style: mTextStyle14()),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        nextButton(
                          title: "Next",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final skillData = await createParamsForSkill();
                              // context
                              //     .read<SkillBloc>()
                              //     .add(SubmitSkills(skillData));
                              _prefs.clear(PreferencesManager.SKILL_PARAMS);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SignupPageYourPreferences(
                                    params: widget.params,
                                  ),
                                ),
                              );
                            } else {
                              showSnackbar(
                                'Please enter all the details',
                                context,
                              );
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

  Future<FormData> createParamsForSkill() async {
    final prefs = sl<PreferencesManager>();
    // final user_id = '1';
    final user_id = prefs.getuser_id() ?? '1';

    // Step 1: Construct skill list
    List<Map<String, dynamic>> skillList = [];

    for (int i = 0; i < selectedDomains.length; i++) {
      final skill = selectedDomains[i];
      final authority = courseCollegeControllers[skill]?.text ?? '';

      skillList.add({
        // 'skill_id': 1,
        "skill": skill,
        "authority": authority,
      });
    }

    // Step 2: Create FormData
    final formData = FormData();

    formData.fields
      ..add(MapEntry('user_id', user_id))
      ..add(MapEntry('skills', jsonEncode(skillList)));

    // Step 3: Attach certificate images with indexed keys
    int index = 0;
    for (var domain in certificateImages.keys) {
      final file = certificateImages[domain].files.first;
      if (file != null) {
        final fileName = file.path.split('/').last;
        formData.files.add(
          MapEntry(
            'certificate_image_$index',
            await MultipartFile.fromFile(file.path, filename: fileName),
          ),
        );
        index++;
      }
    }

    developer.log(
      'For Data of skill\nfields : ${formData.fields}\nfiles : ${formData.files}',
    );

    return formData;
  }
}
