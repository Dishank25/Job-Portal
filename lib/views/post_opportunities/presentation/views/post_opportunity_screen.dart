import 'dart:developer' as developer show log;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/utils/constants/image_string.dart';
import 'package:job_portal/views/bottom_nav_bar/recruiter_bottom_nav_bar.dart';
import 'package:job_portal/ui_helper/ui_helper.dart';
import 'package:job_portal/views/post_opportunities/domain/entities/internship_metadata_entity.dart';
import 'package:job_portal/views/post_opportunities/presentation/bloc/opportunity_bloc.dart';
import 'package:job_portal/views/post_opportunities/presentation/bloc/opportunity_event.dart';
import 'package:job_portal/views/post_opportunities/presentation/bloc/opportunity_state.dart';
import 'package:job_portal/widgets/widgets.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import '../../domain/entities/skills_by_domain_entity.dart';

class PostInternshipsScreen extends StatefulWidget {
  final int user_id;
  PostInternshipsScreen({super.key, required this.user_id});

  @override
  State<PostInternshipsScreen> createState() => _PostInternshipsScreenState();
}

class _PostInternshipsScreenState extends State<PostInternshipsScreen> {
  int? selectedJobIndex; // 0 = Low, 1 = Medium, 2 = High
  int? selectedLocationIndex;
  int? selectedTimingIndex;
  int? selectedStartTimingIndex;
  int? selectedStipendIndex;
  int? selectedStipendBasisIndex;
  int? selectedIncentiveBasisIndex;
  bool isChecked = false;
  bool isPPO = false;
  bool isSelectedCity = false;
  int selectedDay = -1;
  bool isWomenAllowed = false;
  bool onlySelectedCollege = false;

  final TextEditingController _college_nameController = TextEditingController();
  final TextEditingController _screeningQuestionsController =
      TextEditingController();

  final List<String> JobTypes = ["Internships", "Jobs"];
  final List<String> internshipLocationTypes = [
    "In Office",
    "Hybrid",
    "Remote"
  ];
  final List<String> internshipDayTimingsTypes = ["Part-time", "Full-time"];
  final List<String> internshipStartTimingsTypes = [
    "Immediately (Within 30 days)",
    "Custom"
  ];
  final List<String> stipendTypes = ["Paid", "Unpaid"];
  final List<String> stipendBasis = ["/Weekly", "/Monthly", "Lump-sum"];
  final List<String> IncentivesBasis = ["/Weekly", "/Monthly", "Lump-sum"];
  final List<int> days = [1, 2, 3, 4, 5];
  Set<String> selectedCourses = {};

  List<String> getSkillsForDomain(String? domainName) {
    if (domainName == null || metadata == null) return [];

    final domainId = metadata?.domainsMap[domainName];
    if (domainId == null) return [];

    final domainSkills = metadata?.skillsByDomain.firstWhere(
        (d) => d.domainId == domainId,
        orElse: () => SkillsByDomain(domainId: -1, domainName: '', skills: []));

    return domainSkills?.skills.map((s) => s.skillName).toList() ?? [];
  }

  final List<String> options = [
    "Certificate",
    "Letter of recommendation",
    "Flexible work hours",
    "5 days a week",
    "Informal dress code",
    "Free snacks & beverages"
  ];
  final List<String> JobPerks = [
    "5 days a week",
    "Health Insurance",
    "Life Insurance"
  ];

  List<bool> isTicked = [false, false, false, false, false, false];
  List<bool> isClicked = [false, false, false];
  List<String> requiredSkills = [];
  List<String> selectedCitiesList = [];
  List<String> courses = [
    'B.Tech',
    'BE',
    'B.Com',
    'MBA',
    'BA',
    'B.Sc',
    'M.Tech',
    'MCA',
    'Diploma'
  ];

  UniqueKey _skillAutoCompleteKey = UniqueKey();
  UniqueKey _citiesAutoCompleteKey = UniqueKey();

  InternshipMetadataEntity? metadata;

  String sendOnlyTickedPerksForInternship() {
    List<String> selectedOptions = [
      for (int i = 0; i < options.length; i++)
        if (isTicked[i]) options[i]
    ];
    return buildCommaSeparatedString(selectedOptions);
  }

  String sendOnlyTickedPerksForJobs() {
    List<String> selectedJobPerks = [
      for (int i = 0; i < JobPerks.length; i++)
        if (isClicked[i]) JobPerks[i]
    ];
    return buildCommaSeparatedString(selectedJobPerks);
  }

  // void createParamsForJobPost() {
  //   final map = {
  //     "opportunity_type": JobTypes[selectedJobIndex ?? 0],
  //     "jobRole": InternshipProfileController.text.trim(),
  //     "skillsRequired": buildCommaSeparatedString(requiredSkills),
  //     "skill_required_note": '',
  //     "job_type": internshipLocationTypes[selectedLocationIndex ?? 0],
  //     "days_in_office": selectedLocationIndex == 1 ? selectedDay : null,
  //     "job_time": selectedLocationIndex == 1 || selectedLocationIndex == 2
  //         ? internshipDayTimingsTypes[selectedTimingIndex ?? 0]
  //         : null,
  //     "cityChoice": buildCommaSeparatedString(selectedCitiesList),
  //     "number_of_openings": no_openingController.text.trim(),
  //     "job_description": responsibilitiesController.text.trim(),
  //     "candidate_preferences": preferencesController.text.trim(),
  //     "women_preferred": isWomenAllowed,
  //     "stipend_type": stipendTypes[selectedStipendIndex ?? 0],
  //     "stipend_min":
  //         selectedStipendIndex == 0 ? minStipendController.text.trim() : 0,
  //     "stipend_max":
  //         selectedStipendIndex == 0 ? maxStipendController.text.trim() : 0,
  //     "incentive_per_year": minIncentivesController.text.trim(),
  //     "perks": selectedJobIndex == 0
  //         ? sendOnlyTickedPerksForInternship()
  //         : selectedJobIndex == 1
  //             ? sendOnlyTickedPerksForJobs()
  //             : '',
  //     "screening_questions": _screeningQuestionsController.text,
  //     "phone_contact": '',
  //     "alternate_phone_number": alterPhoneController.text.trim(),
  //     "internshipDuration": internshipDurationController.text.trim(),
  //     // "internship_start_date":
  //     //     internshipStartTimingsTypes[selectedStartTimingIndex ?? 0],
  //     "internship_from_date": selectedStartTimingIndex == 1
  //         ? startDateController.text.trim()
  //         : null,
  //     "internship_to_date":
  //         selectedStartTimingIndex == 1 ? endDateController.text.trim() : null,
  //     "is_custom_internship_date": selectedStartTimingIndex == 1,
  //     "college_name": _college_nameController.text.trim(),
  //     "course": selectedCourses.join(', '),
  //   };

  //   developer.log('This is the opportunity post params : $map');

  //   context.read<OpportunityBloc>().add(OpportunityCreateJobPost(map));
  Map<String, dynamic> createParamsForJobPost() {
    try {
      // ✅ Use the passed user_id
      final int? userId = widget.user_id;
      if (userId == null) {
        throw Exception('User ID is missing. Cannot post job.');
      }

      // 1. Get domain ID
      String? selectedDomain = InternshipProfileController.text.trim();
      int? jobRoleId = metadata?.domainsMap[selectedDomain];
      if (jobRoleId == null) {
        developer.log('❌ No domain ID found for: $selectedDomain');
        throw Exception('Invalid domain selected');
      }

      // 2. Get skill IDs
      List<int> skillIds = requiredSkills
          .map((skill) {
            int? id = metadata?.skillsMap[skill];
            if (id == null) {
              developer.log('⚠️ Skill ID not found for: $skill');
            }
            return id ?? 0;
          })
          .where((id) => id != 0)
          .toList();

      if (skillIds.isEmpty && requiredSkills.isNotEmpty) {
        developer.log('❌ No valid skill IDs found');
        throw Exception('No valid skills selected');
      }

      // 3. Get city IDs
      List<int> eligibleCityIds = selectedCitiesList
          .map((city) => metadata?.citiesMap[city])
          .whereType<int>()
          .toList();

      // 4. Perks
      String perksText = selectedJobIndex == 0
          ? sendOnlyTickedPerksForInternship()
          : selectedJobIndex == 1
              ? sendOnlyTickedPerksForJobs()
              : '';
      List<String> perksList =
          perksText.isNotEmpty ? perksText.split(', ') : [];

      // 5. Duration ID
      String durationText = internshipDurationController.text.trim();
      int? durationId = metadata?.durationMap[durationText];

      // 6. Stipend
      int? stipendMin = selectedStipendIndex == 0
          ? int.tryParse(minStipendController.text.trim())
          : 0;
      int? stipendMax = selectedStipendIndex == 0
          ? int.tryParse(maxStipendController.text.trim())
          : 0;

      // 7. Dates
      bool isCustomDate = selectedStartTimingIndex == 1;
      String? startDate = isCustomDate ? startDateController.text.trim() : null;

      // 8. Mock college/course IDs (replace with real logic later)
      List<int> eligibleCourseIds = [1];
      List<int> eligibleCollegeIds = [2];

      // 9. Build final map
      final Map<String, dynamic> map = {
        "company_recruiter_profile_id": userId, // ✅ Fixed: use passed user_id
        "opportunity_type": selectedJobIndex == 0 ? "Internship" : "Job",
        "job_role_id": jobRoleId,
        "skill_ids": skillIds,
        "skill_required_note": "",
        "job_type": internshipLocationTypes[selectedLocationIndex ?? 0],
        "job_time": (selectedLocationIndex == 1 || selectedLocationIndex == 2)
            ? internshipDayTimingsTypes[selectedTimingIndex ?? 0]
            : null,
        "days_in_office": selectedLocationIndex == 1 ? selectedDay : null,
        "number_of_openings": no_openingController.text.trim(),
        "job_description": responsibilitiesController.text.trim(),
        "candidate_preferences": preferencesController.text.trim(),
        "women_preferred": isWomenAllowed,
        "stipend_type": stipendTypes[selectedStipendIndex ?? 0] == "Paid"
            ? "Fixed"
            : "Unpaid",
        "stipend_min": stipendMin,
        "stipend_max": stipendMax,
        "incentive_per_year": minIncentivesController.text.trim(),
        "perks": perksList,
        "screening_questions":
            _screeningQuestionsController.text.trim().isNotEmpty
                ? [_screeningQuestionsController.text.trim()]
                : [],
        "phone_contact": "",
        "alternate_phone_number": alterPhoneController.text.trim(),
        "duration_id": durationId,
        "internship_start_date": startDate,
        "is_custom_internship_date": isCustomDate,
        "eligible_college_ids": eligibleCollegeIds,
        "eligible_course_ids": eligibleCourseIds,
        "eligible_city_ids": eligibleCityIds,
      };

      developer.log('✅ Final createJobPost payload: $map');
      return map;
    } catch (e, s) {
      developer.log('❌ Error in createParamsForJobPost: $e\n$s');
      rethrow;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final bloc = context.read<OpportunityBloc>();
    bloc.add(const OpportunityMetaDataLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.double_arrow),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<OpportunityBloc, OpportunityState>(
                listener: (context, state) {
                  if (state is OpportunityMetadataLoaded) {
                    setState(() {
                      metadata = state.internshipMetadata;
                    });
                    developer.log("Meta data : $metadata");
                    if (metadata != null) {
                      developer.log("✅ UI: Domains = ${metadata?.domains}");
                      developer.log("✅ UI: Cities = ${metadata?.cities}");
                      developer.log("✅ UI: Duration = ${metadata?.duration}");
                      developer.log(
                          "✅ UI: DomainsMap IDs = ${metadata?.domainsMap.values}");
                    }
                  } else if (state is OpportunityMetadataLoading) {
                    developer.log("Metadata is loading");
                  } else if (state is OpportunityMetadataError) {
                    developer
                        .log("some error encountered while loading metadata.");
                  }
                },
                child: const SizedBox(),
              ),
              // const Text(
              //   "Logo",
              //   style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w700,
              //       color: TColors.primary),
              // ),
              SvgPicture.asset(
                ImageString.jobPortalLogo,
                height: 30,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Post internships jobs",
                style: mTextStyle32(mColor: Colors.black),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Hire early talent with work experience up to 2 years",
                style: mTextStyle12(mFontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 25,
              ),

              /// CheckBox Row (Opportunity type)
              Text(
                "Opportunity Type",
                style: mTextStyle12(),
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                height: 46,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(JobTypes.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          RoundCheckBox(
                            size: 22,
                            isChecked: selectedJobIndex == index,
                            onTap: (selected) {
                              setState(() {
                                selectedJobIndex = selected! ? index : null;
                              });
                            },
                            checkedColor: Colors.blue,
                            uncheckedColor: Colors.white,
                            checkedWidget: Icon(Icons.check,
                                size: 15, color: Colors.white),
                          ),
                          const SizedBox(width: 6),
                          Text(JobTypes[index], style: mTextStyle12()),
                          // const SizedBox(height: 6),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              /// Profile TEXT FIELD
              const SizedBox(
                height: 20,
              ),
              Text(
                selectedJobIndex == 0 ? "Internship Profile" : "Job Profile",
                style: mTextStyle12(),
              ),
              const SizedBox(
                height: 3,
              ),
              // CustomTextField(
              //   controller: InternshipProfileController,
              //   hintText: "E.g Digital Marketing",
              //   fillColor: const Color(0xffFFF7FB),
              // ),
              CustomAutocomplete(
                options: metadata != null ? metadata!.domains : [],
                label: 'E.g Digital Marketing',
                onSelected: (value) {
                  InternshipProfileController.text = value;
                  setState(() {
                    requiredSkills.clear();
                    _skillAutoCompleteKey =
                        UniqueKey(); //Forces rebuild of skills autocomplete
                  });
                },
              ),

              ///Skills required TEXT FIELD
              const SizedBox(
                height: 20,
              ),
              Text(
                "Skills Required",
                style: mTextStyle12(),
              ),
              const SizedBox(
                height: 3,
              ),
              // CustomTextField(
              //   controller: SkillsRequiredController,
              //   hintText: "E.g SEO",
              //   fillColor: Color(0xffFFF7FB),
              // ),
              Container(
                key: _skillAutoCompleteKey,
                child: CustomAutocomplete(
                  options: getSkillsForDomain(
                      InternshipProfileController.text.trim()),
                  label: 'E.g SEO',
                  onSelected: (value) {
                    setState(() {
                      if (!requiredSkills.contains(value)) {
                        requiredSkills.add(value);
                      }
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (requiredSkills.isNotEmpty)
                SizedBox(
                  height:
                      35, // Set appropriate height to contain your horizontal items
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Makes the list horizontal
                    itemCount: requiredSkills.length,
                    itemBuilder: (context, index) {
                      final reqSkill = requiredSkills[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: courseName(
                          name: reqSkill,
                          bgColor: Colors.blue,
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                          onCrossTap: () {
                            setState(() {
                              requiredSkills.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

              if (requiredSkills.isNotEmpty)
                SizedBox(
                  height: 5,
                ),

              /// CheckBox Row (Internship type)
              Text(
                selectedJobIndex == 0 ? "Internship type" : "Job type",
                style: mTextStyle12(),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                height: 46,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                ),

                /// Logic for job location: In-office/ Hybrid
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                      List.generate(internshipLocationTypes.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          RoundCheckBox(
                            size: 22,
                            isChecked: selectedLocationIndex == index,
                            onTap: (selected) {
                              setState(() {
                                selectedLocationIndex =
                                    selected! ? index : null;
                              });
                            },
                            checkedColor: Colors.blue,
                            uncheckedColor: Colors.white,
                            checkedWidget: Icon(Icons.check,
                                size: 15, color: Colors.white),
                          ),
                          const SizedBox(width: 6),
                          Text(internshipLocationTypes[index],
                              style: mTextStyle12()),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              if (selectedLocationIndex == 0)
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "City/Cities",
                        style: mTextStyle12(),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      // CustomTextField(
                      //   controller: cityController,
                      //   hintText: "E.g Mumbai",
                      //   fillColor: Color(0xffFFF7FB),
                      // ),
                      Container(
                        key: _citiesAutoCompleteKey,
                        child: CustomAutocomplete(
                            options: metadata != null ? metadata!.cities : [],
                            label: 'E.g Mumbai',
                            onSelected: (value) {
                              setState(() {
                                if (!selectedCitiesList.contains(value)) {
                                  selectedCitiesList.add(value);
                                }
                                _citiesAutoCompleteKey = UniqueKey();
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (selectedCitiesList.isNotEmpty)
                        SizedBox(
                          height:
                              35, // Set appropriate height to contain your horizontal items
                          child: ListView.builder(
                            scrollDirection:
                                Axis.horizontal, // Makes the list horizontal
                            itemCount: selectedCitiesList.length,
                            itemBuilder: (context, index) {
                              final reqSkill = selectedCitiesList[index];

                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: courseName(
                                  name: reqSkill,
                                  bgColor: Colors.blue,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  onCrossTap: () {
                                    setState(() {
                                      selectedCitiesList.removeAt(index);
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isSelectedCity,
                            onChanged: (value) {
                              setState(() {
                                isSelectedCity = value!;
                              });
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Candidates from ONLY the above city should be\n allowed to apply.',
                            style: mTextStyle12(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              if (selectedLocationIndex == 1)
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No. of in-office days in a week:",
                          style: mTextStyle12(),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Wrap(
                          spacing: 12,
                          children: days.map((day) {
                            return ChoiceChip(
                              label: Text(
                                day.toString(),
                                style: mTextStyle12(),
                              ),
                              selected: selectedDay == day,
                              onSelected: (_) {
                                setState(() {
                                  selectedDay = day;
                                });
                              },
                              selectedColor: Colors.blue.shade100,
                              backgroundColor: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: selectedDay == day
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: selectedDay == day
                                    ? Colors.blue.shade800
                                    : Colors.black,
                              ),
                            );
                          }).toList(),
                        ),
                      ]),
                ),
              SizedBox(
                height: 20,
              ),

              /// CheckBox Row (Internship Daily Timing type)
              Text(
                "Part time/ Full time",
                style: mTextStyle12(),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                height: 46,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                      List.generate(internshipDayTimingsTypes.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          RoundCheckBox(
                            size: 22,
                            isChecked: selectedTimingIndex == index,
                            onTap: (selected) {
                              setState(() {
                                selectedTimingIndex = selected! ? index : null;
                              });
                            },
                            checkedColor: Colors.blue,
                            uncheckedColor: Colors.white,
                            checkedWidget: Icon(Icons.check,
                                size: 15, color: Colors.white),
                          ),
                          const SizedBox(width: 6),
                          Text(internshipDayTimingsTypes[index],
                              style: mTextStyle12()),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              /// CheckBox Row (Internship Joining Timing type)
              Text(
                "Internship start date",
                style: mTextStyle12(),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                height: 46,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(internshipStartTimingsTypes.length,
                      (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          RoundCheckBox(
                            size: 22,
                            isChecked: selectedStartTimingIndex == index,
                            onTap: (selected) {
                              setState(() {
                                selectedStartTimingIndex =
                                    selected! ? index : null;
                              });
                            },
                            checkedColor: Colors.blue,
                            uncheckedColor: Colors.white,
                            checkedWidget: Icon(Icons.check,
                                size: 15, color: Colors.white),
                          ),
                          const SizedBox(width: 6),
                          Text(internshipStartTimingsTypes[index],
                              style: mTextStyle12()),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              if (selectedStartTimingIndex == 1)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "From",
                            style: mTextStyle12(),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            "To",
                            style: mTextStyle12(),
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: startDateController,
                              hintText: "Start Date ",
                              fillColor: Color(0xffFFF7FB),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              controller: endDateController,
                              hintText: "End Date ",
                              fillColor: Color(0xffFFF7FB),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              /// Internship duration text field
              SizedBox(
                height: 20,
              ),
              Text(
                "Internship duration",
                style: mTextStyle12(),
              ),
              Row(
                children: [
                  // SizedBox(
                  //   width: 240,
                  //   child: CustomTextField(
                  //     controller: internshipDurationController,
                  //     hintText: "Choose Duration",
                  //     suffixIcon: Icons.keyboard_arrow_down,
                  //     onSuffixTap: () {},
                  //     fillColor: Color(0xffFFF7FB),
                  //   ),
                  // ),
                  SizedBox(
                      width: 240,
                      child: CustomAutocomplete(
                          options: metadata != null ? metadata!.duration : [],
                          label: 'Choose duration',
                          onSelected: (value) {
                            internshipDurationController.text = value;
                          })),
                  SizedBox(
                    width: 6,
                  ),
                  // Expanded(
                  //   child: CustomTextField(
                  //     controller: internshipDurationMonthsController,
                  //     hintText: "Months",
                  //     suffixIcon: Icons.keyboard_arrow_down,
                  //     onSuffixTap: () {},
                  //     fillColor: Color(0xffFFF7FB),
                  //   ),
                  // )

                  Expanded(
                    child: CustomAutocomplete(
                      options: metadata != null ? metadata!.startMonth : [],
                      label: "Months",
                      onSelected: (value) {
                        internshipDurationMonthsController.text = value;
                      },
                    ),
                  ),
                ],
              ),

              /// Number of opening text field
              SizedBox(
                height: 20,
              ),
              Text(
                "Number of Openings",
                style: mTextStyle12(),
              ),
              SizedBox(
                height: 3,
              ),
              CustomTextField(
                controller: no_openingController,
                hintText: "E.g 4",
                // fillColor: Color(0xffFFF7FB),
              ),

              /// Intern's Responsibility text field
              SizedBox(
                height: 20,
              ),
              Text(
                selectedJobIndex == 0
                    ? "Intern responsibility"
                    : "Job description",
                style: mTextStyle12(),
              ),
              SizedBox(
                height: 3,
              ),
              TextField(
                controller: responsibilitiesController,
                maxLines: 10,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Enter preferences (one per line)",
                  hintStyle: mTextStyle12(
                      mFontWeight: FontWeight.w500,
                      mColor: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300), // Change color as needed
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              /// Additional Candidates Preferences text field
              SizedBox(
                height: 20,
              ),
              Text(
                "Additional Candidates Preferences",
                style: mTextStyle12(),
              ),
              SizedBox(
                height: 3,
              ),
              TextField(
                controller: preferencesController,
                maxLines: 4,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Enter preferences (one per line)",
                  hintStyle: mTextStyle12(
                      mFontWeight: FontWeight.w500,
                      mColor: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300), // Change color as needed
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isWomenAllowed,
                    onChanged: (value) {
                      setState(() {
                        isWomenAllowed = value!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Text(
                      "Allow applications from women who are willing to \nstart/restart their career.",
                      style: mTextStyle12(),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              /// Stipend CheckBox Row
              if (selectedJobIndex == 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stipend",
                      style: mTextStyle12(),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      height: 46,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 1, color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(stipendTypes.length, (index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                RoundCheckBox(
                                  size: 22,
                                  isChecked: selectedStipendIndex == index,
                                  onTap: (selected) {
                                    setState(() {
                                      selectedStipendIndex =
                                          selected! ? index : null;
                                    });
                                  },
                                  checkedColor: Colors.blue,
                                  uncheckedColor: Colors.white,
                                  checkedWidget: Icon(Icons.check,
                                      size: 15, color: Colors.white),
                                ),
                                const SizedBox(width: 6),
                                Text(stipendTypes[index],
                                    style: mTextStyle12()),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),

              /// Conditional code for fixed pay in case of opportunity type- JOBS
              if (selectedJobIndex == 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fixed pay (per year)",
                            style: mTextStyle12(),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextField(
                                      controller: minSalaryController,
                                      hintText: "Min.Salary",
                                      fillColor: Color(0xffFFF7FB))),
                              SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                  child: CustomTextField(
                                      controller: maxSalaryController,
                                      hintText: "Max.Salary",
                                      fillColor: Color(0xffFFF7FB))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 20,
              ),

              /// Conditional code for fixed pay in case of opportunity type- Internships
              if (selectedJobIndex == 0 && selectedStipendIndex == 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fixed Stipend",
                      style: mTextStyle12(),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                              // width: 170,
                              child: CustomTextField(
                            controller: minStipendController,
                            hintText: "min. Stipend",
                            fillColor: Color(0xffFFF7FB),
                          )),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          child: SizedBox(
                              // width: 170,
                              child: CustomTextField(
                            controller: maxStipendController,
                            hintText: "max. Stipend",
                            fillColor: Color(0xffFFF7FB),
                          )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //  crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(stipendBasis.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              RoundCheckBox(
                                size: 22,
                                isChecked: selectedStipendBasisIndex == index,
                                onTap: (selected) {
                                  setState(() {
                                    selectedStipendBasisIndex =
                                        selected! ? index : null;
                                  });
                                },
                                checkedColor: Colors.blue,
                                uncheckedColor: Colors.white,
                                checkedWidget: Icon(Icons.check,
                                    size: 15, color: Colors.white),
                              ),
                              const SizedBox(width: 6),
                              Text(stipendBasis[index], style: mTextStyle12()),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),

              if (selectedJobIndex == 1 || selectedStipendIndex == 0)
                Row(
                  children: [
                    Text(
                      selectedJobIndex == 1
                          ? "Variables/Incentives (per year)"
                          : "Incentives",
                      style: mTextStyle12(),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              if (selectedJobIndex == 0 && selectedStipendIndex == 0 ||
                  selectedJobIndex == 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: CustomTextField(
                      controller: minIncentivesController,
                      hintText: "min. Incentive",
                      fillColor: Color(0xffFFF7FB),
                    )),
                    SizedBox(width: 18),
                    Expanded(
                        child: CustomTextField(
                      controller: maxIncentivesController,
                      hintText: "max. Incentive",
                      fillColor: Color(0xffFFF7FB),
                    ))
                  ],
                ),
              if (selectedJobIndex == 0 && selectedStipendIndex == 0)
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(IncentivesBasis.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            RoundCheckBox(
                              size: 22,
                              isChecked: selectedIncentiveBasisIndex == index,
                              onTap: (selected) {
                                setState(() {
                                  selectedIncentiveBasisIndex =
                                      selected! ? index : null;
                                });
                              },
                              checkedColor: Colors.blue,
                              uncheckedColor: Colors.white,
                              checkedWidget: Icon(Icons.check,
                                  size: 15, color: Colors.white),
                            ),
                            const SizedBox(width: 6),
                            Text(IncentivesBasis[index], style: mTextStyle12()),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              // const SizedBox(
              //   height: 20,
              // ),
              Row(
                children: [
                  Text(
                    'College Name',
                    style: mTextStyle12(),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(50, 29, 179, 47),
                        ),
                        color: const Color.fromARGB(25, 29, 179, 47),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'PRO Plan',
                        style: TextStyle(
                          color: Color.fromARGB(255, 29, 179, 47),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              CustomTextField(
                controller: _college_nameController,
                hintText: "IITD",
                // fillColor: const Color(0xffFFF7FB),
              ),
              Row(
                children: [
                  Checkbox(
                    value: onlySelectedCollege,
                    onChanged: (value) {
                      setState(() {
                        onlySelectedCollege = value!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Text(
                      "Candidates from ONLY the above college should be\nallowed to apply.",
                      style: mTextStyle12(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Courses',
                style: mTextStyle12(),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: courses.map((course) {
                  final isSelected = selectedCourses.contains(course);
                  return courseName(
                    name: course,
                    bgColor: isSelected ? Colors.blue : Colors.white,
                    textColor: isSelected ? Colors.white : Colors.black,
                    borderColor: isSelected ? Colors.blue : Colors.grey,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCourses.remove(course);
                        } else {
                          selectedCourses.add(course);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                "Perks: (Select all that apply)",
                style: mTextStyle12(
                    // ignore: deprecated_member_use
                    mColor: Colors.black.withOpacity(0.6),
                    mFontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 6,
              ),
              selectedJobIndex == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(options.length, (index) {
                        return Row(children: [
                          Checkbox(
                            value: isTicked[index],
                            onChanged: (value) {
                              setState(() {
                                isTicked[index] = value!;
                              });
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            options[index],
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey.shade700),
                          ),
                        ]);
                      }),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(JobPerks.length, (index) {
                        return Row(
                          children: [
                            Checkbox(
                              value: isClicked[index],
                              onChanged: (value) {
                                setState(() {
                                  isClicked[index] = value!;
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              JobPerks[index],
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey.shade700),
                            )
                          ],
                        );
                      }),
                    ),
              SizedBox(
                height: 4,
              ),
              if (selectedJobIndex == 0)
                Row(
                  children: [
                    RoundCheckBox(
                      size: 22,
                      isChecked: isPPO,
                      onTap: (selected) {
                        setState(() {
                          isPPO = !isPPO;
                        });
                      },
                      checkedColor: Colors.blue,
                      uncheckedColor: Colors.white,
                      checkedWidget:
                          Icon(Icons.check, size: 15, color: Colors.white),
                    ),
                    const SizedBox(width: 6),
                    Text(
                        "Does this internship come with a pre-placement offer\n (PPO)?",
                        style: mTextStyle12(mColor: AppColors.blueTextColor)),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Screening Questions",
                style: mTextStyle14(),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Availability (Default)",
                style: mTextStyle12(),
              ),
              const SizedBox(
                height: 6,
              ),
              TextField(
                controller: _screeningQuestionsController,
                maxLines: 4,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText:
                      "Please confirm your availability for this internship. If not available immediately, how early would you be able to join?",
                  hintStyle: mTextStyle12(
                      mFontWeight: FontWeight.w500,
                      mColor: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300), // Change color as needed
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border:
              //           Border.all(width: 1, color: Colors.grey.shade300)),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //         horizontal: 8.0, vertical: 8),
              //     child: Text(
              //       "Please confirm your availability for this internship. If not available immediately, how early would you be able to join?",
              //       style: mTextStyle12(),
              //     ),
              //   ),
              // ),
              // InkWell(
              //     onTap: () {},
              //     child: Text(
              //       "+ Add more questions (Optional) ",
              //       style: mTextStyle12(mColor: AppColors.blueTextColor),
              //     )),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Alternate phone number for this listing (Optional)",
                style: mTextStyle12(),
              ),
              SizedBox(
                height: 4,
              ),
              // CustomTextField(
              //   controller: alterPhoneController,
              //   hintText: "+91- 9977665543",
              //   // fillColor: Color(0xffFFF7FB),
              // ),
              CustomPhoneField(controller: alterPhoneController),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Color(0xff6C7278))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Icon(Icons.arrow_back, size: 16,),
                          Text(
                            "Stay Draft",
                            style: mTextStyle14(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocListener<OpportunityBloc, OpportunityState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is OpportunityJobPostLoaded) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecruiterBottomNavBar(),
                          ),
                        );
                      } else if (state is OpportunityJobPostError) {
                        showSnackbar('Some error occured.', context);
                      } else if (state is OpportunityJobPostLoading) {
                        showSnackbar('Processing', context);
                      }
                    },
                    child: SizedBox(
                      width: 150,
                      child: nextButton(
                          title: "Post Internship",
                          onTap: () {
                            try {
                              final map = createParamsForJobPost();
                              context
                                  .read<OpportunityBloc>()
                                  .add(OpportunityCreateJobPost(map));
                            } catch (e) {
                              showSnackbar(
                                  'Please fill all required fields correctly.',
                                  context);
                            }
                          }),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  String buildCommaSeparatedString(List<String> list) {
    return list.join(', ');
  }
}
