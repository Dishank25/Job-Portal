import 'dart:developer' as developer show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/utils/constants/enums.dart';
import 'package:job_portal/utils/constants/image_string.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/basic_user_data_response.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/signup_as_anyone_bloc/detailed_signup_bloc.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/signup_as_anyone_bloc/detailed_signup_event.dart';
import 'package:job_portal/views/detailed_signup_student/presentation/bloc/signup_as_anyone_bloc/detailed_signup_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../ui_helper/ui_helper.dart';
import '../../../../widgets/widgets.dart';
import 'signup_your_skills_view.dart';

class SignupAsAnyOne extends StatefulWidget {
  final String email;
  Map<String, dynamic> params = {};
  // final BasicUserInfoResponse basicUserInfoResponse;

  SignupAsAnyOne({
    super.key,
    // required this.basicUserInfoResponse,
    required this.email,
  });
  @override
  State<SignupAsAnyOne> createState() => _SignInPageUniversityStudentState();
}

class _SignInPageUniversityStudentState extends State<SignupAsAnyOne> {
  String selectedOption = '';
  String? selectedClass;
  String? selectedCourse;
  String? selectedCurrentCity;
  String? selectedPreferredCity;
  String? selectedSpecialization;
  String? selectedjobRole;
  TextEditingController totalWorkExp = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  ///FOR COLLEGE DROPDOWN
  final LayerLink _collegeLayerLink = LayerLink();
  OverlayEntry? _collegeOverLayEntry;
  final GlobalKey _collegeFieldKey = GlobalKey();

  String selectedCollege = '';
  List<String> collegeNames = [];
  List<String> cities = [];
  List<String> selectedCourses = [];

  @override
  void dispose() {
    _collegeOverLayEntry?.remove();
    collegeController.dispose();
    super.dispose();
  }

  void _showDropdown() {
    final renderBox =
        _collegeFieldKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    // context.read<CollegeBloc>().add(FetchColleges());

    _collegeOverLayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy,
        child: CompositedTransformFollower(
          link: _collegeLayerLink,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(8),
            // child: BlocBuilder<CollegeBloc, CollegeState>(
            //   builder: (context, state) {
            //     if (state is CollegeLoading) {
            //       return const CircularProgressIndicator();
            //     } else if (state is CollegeLoaded) {
            //       return ListView(
            //         shrinkWrap: true,
            //         children: state.colleges.map((name) {
            //           return ListTile(
            //             visualDensity: VisualDensity(vertical: -4),
            //             title: Text(name),
            //             onTap: () {
            //               collegeController.text = name;
            //               _collegeOverLayEntry?.remove();
            //               _collegeOverLayEntry = null;
            //             },
            //           );
            //         }).toList(),
            //       );
            //     } else if (state is CollegeError) {
            //       return Text(state.message);
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_collegeOverLayEntry!);
  }

  /// FOR GENDER DROP DOWN
  final LayerLink _genderLayerLink = LayerLink();
  OverlayEntry? _genderOverlayEntry;
  final GlobalKey _genderKey = GlobalKey();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  String formatDobToIso(String dob) {
    try {
      final parts = dob.split('-'); // ["25", "07", "1985"]
      if (parts.length != 3) return 'Invalid date format';

      final day = parts[0].padLeft(2, '0');
      final month = parts[1].padLeft(2, '0');
      final year = parts[2];

      return '$year-$month-$day';
    } catch (e) {
      return 'Error formatting date';
    }
  }

  void _toggleGenderDropdown() {
    print("Gender dropdown tapped");
    if (_genderOverlayEntry == null) {
      _genderOverlayEntry = _createGenderOverlay();
      Overlay.of(context).insert(_genderOverlayEntry!);
    } else {
      _genderOverlayEntry?.remove();
      _genderOverlayEntry = null;
    }
  }

  OverlayEntry _createGenderOverlay() {
    if (_genderKey.currentContext == null) {
      debugPrint("genderKey currentContext is null");
      return OverlayEntry(
          builder: (_) => const SizedBox.shrink()); // or handle appropriately
    }

    final renderBox = _genderKey.currentContext!.findRenderObject();
    if (renderBox is! RenderBox) {
      debugPrint("RenderObject is not a RenderBox");
      return OverlayEntry(builder: (_) => const SizedBox.shrink());
    }

    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height + 5,
        child: CompositedTransformFollower(
          link: _genderLayerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 100,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: genderOptions.map((option) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    title: Text(option),
                    onTap: () {
                      genderController.text = option;
                      _toggleGenderDropdown();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// FOR SPECIALIZATION DROP DOWN
  final LayerLink _specializationLayerLink = LayerLink();
  OverlayEntry? _specializationOverlayEntry;
  final GlobalKey _specializationKey = GlobalKey();

  void _showSpecializationDropdown() {
    final renderBox =
        _specializationKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    // context.read<SpecializationBloc>().add(FetchSpecializations());

    _specializationOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height,
        child: CompositedTransformFollower(
          link: _specializationLayerLink,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(8),
            // child: BlocBuilder<SpecializationBloc, SpecializationState>(
            //   builder: (context, state) {
            //     if (state is SpecializationLoading) {
            //       return const Padding(
            //         padding: EdgeInsets.all(12),
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (state is SpecializationLoaded) {
            //       return ListView(
            //         padding: EdgeInsets.zero,
            //         shrinkWrap: true,
            //         children: state.specializations.map((name) {
            //           return ListTile(
            //             visualDensity: VisualDensity(vertical: -3),
            //             title: Text(name),
            //             onTap: () {
            //               specializationController.text = name;
            //               _specializationOverlayEntry?.remove();
            //               _specializationOverlayEntry = null;
            //             },
            //           );
            //         }).toList(),
            //       );
            //     } else if (state is SpecializationError) {
            //       return Padding(
            //         padding: const EdgeInsets.all(12),
            //         child: Text(state.message),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_specializationOverlayEntry!);
  }

  /// FOR JOB LOCATION DROP DOWN
  final LayerLink _jobLocationLink = LayerLink();
  final GlobalKey _jobLocationFieldKey = GlobalKey();
  OverlayEntry? _jobLocationOverlayEntry;

  void _showJobLocationDropdown() {
    final renderBox =
        _jobLocationFieldKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    // context.read<JobLocationsBloc>().add(FetchJobLocations());

    _jobLocationOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height,
        child: CompositedTransformFollower(
          link: _jobLocationLink,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            // child: BlocBuilder<JobLocationsBloc, JobLocationsState>(
            //   builder: (context, state) {
            //     if (state is JobLocationsLoadingState) {
            //       return const Padding(
            //         padding: EdgeInsets.all(12),
            //         child: Center(child: CircularProgressIndicator()),
            //       );
            //     } else if (state is JobLocationsLoadedState) {
            //       return ListView(
            //         padding: EdgeInsets.zero,
            //         shrinkWrap: true,
            //         children: state.jobLocations.map((location) {
            //           return ListTile(
            //             dense: true,
            //             visualDensity: VisualDensity(vertical: -3),
            //             title: Text(location),
            //             onTap: () {
            //               JobLocationController.text = location;
            //               _jobLocationOverlayEntry?.remove();
            //               _jobLocationOverlayEntry = null;
            //             },
            //           );
            //         }).toList(),
            //       );
            //     } else if (state is JobLocationsErrorState) {
            //       return Padding(
            //         padding: const EdgeInsets.all(12),
            //         child: Text(state.message),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_jobLocationOverlayEntry!);
  }

  /// FOR JOB ROLES DROP DOWN
  final LayerLink _jobRoleLink = LayerLink();
  final GlobalKey _jobRoleFieldKey = GlobalKey();
  OverlayEntry? _jobRoleOverlayEntry;

  void _showJobRoleDropdown() {
    final renderBox =
        _jobRoleFieldKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    // context.read<JobRoleBloc>().add(FetchJobRoles());

    _jobRoleOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height,
        child: CompositedTransformFollower(
          link: _jobRoleLink,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            // child: BlocBuilder<JobRoleBloc, JobRoleState>(
            //   builder: (context, state) {
            //     if (state is JobRoleLoadingState) {
            //       return const Padding(
            //         padding: EdgeInsets.all(12),
            //         child: Center(child: CircularProgressIndicator()),
            //       );
            //     } else if (state is JobRoleLoadedState) {
            //       return ListView(
            //         padding: EdgeInsets.zero,
            //         shrinkWrap: true,
            //         children: state.JobRoles.map((role) {
            //           return ListTile(
            //             dense: true,
            //             visualDensity: VisualDensity(vertical: -3),
            //             title: Text(role),
            //             onTap: () {
            //               jobRoleController.text = role;
            //               _jobRoleOverlayEntry?.remove();
            //               _jobRoleOverlayEntry = null;
            //             },
            //           );
            //         }).toList(),
            //       );
            //     } else if (state is JobRoleErrorState) {
            //       return Padding(
            //         padding: const EdgeInsets.all(12),
            //         child: Text(state.message),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_jobRoleOverlayEntry!);
  }

  /// TEXT FIELDS USED
  final firstnameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final DOBController = TextEditingController();
  final cityController = TextEditingController();
  final genderController = TextEditingController();
  final collegeController = TextEditingController();
  final specializationController = TextEditingController();
  final startCourseYearController = TextEditingController();
  final endCourseYearController = TextEditingController();
  final startJobYearController = TextEditingController();
  final endJobYearController = TextEditingController();
  final TWXController = TextEditingController();
  final jobRoleController = TextEditingController();
  final currentCompany = TextEditingController();
  final CTCController = TextEditingController();
  final JobLocationController = TextEditingController();

  /// API CALLED TO FETCH BASIC USER DATA
  @override
  void initState() {
    super.initState();
    // fetchUserData();
    // context.read<CourseBloc>().add(FetchCourses());
    // context.read<CollegeBloc>().add(FetchColleges());
    // firstnameController.text = 'first name';
    // surnameController.text = "last name";
    // emailController.text = "email";
    // phoneController.text = "4564564565";
  }

  @override
  void didChangeDependencies() {
    final bloc = context.read<DetailedSignupBloc>();
    // final emailMap = {'email': 'dikshavashist2007@gmail.com'};
    final emailMap = {'email': widget.email};
    // bloc.add(DetailedSignupGetCollegeDetails(emailMap));
    bloc.add(DetailedSignupGetBasicUserInfo(emailMap));
    super.didChangeDependencies();
  }

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString("user_email");
    if (email == null) {
      print("No email found in SharedPreferences.");
    } else {
      print("Retrieved email: $email");
    } //  Email from login screen

    if (email != null && email.isNotEmpty) {
      // context.read<FetchUserBloc>().add(FetchUserDetailsEvent(email: email));
    } else {
      print("No email found in SharedPreferences.");
    }
  }

  @override
  Widget build(BuildContext context) {
    /// MAIN UI PERSPECTIVE CODE
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
                      builder: (context) => SignupPageYourSkills(params: {})));
            },
            icon: const Icon(Icons.double_arrow),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocListener<DetailedSignupBloc, DetailedSignupState>(
                    listener: (context, state) {
                      if (state is DetailedSignupGetBasicUserInfoLoaded) {
                        final data = state.basicUserInfoResponse;
                        developer.log(
                            "this is listner bloc, data from basicUSerINfoResponse $data");
                        final locations = state.locations;
                        developer.log(
                            "this is listner bloc, data from basicUSerINfoResponse $locations");

                        setState(() {
                          firstnameController.text = data.user.first_name;
                          surnameController.text = data.user.last_name;
                          emailController.text = data.user.email;
                          phoneController.text = data.user.phone;
                          cities = locations.locations;
                        });
                        final emailMap = {'email': widget.email};
                        context
                            .read<DetailedSignupBloc>()
                            .add(DetailedSignupGetCollegeDetails(emailMap));
                      }
                    },
                    child: const SizedBox(),
                  ),

                  /// HEADER
                  // Text(
                  //   "Logo",
                  //   style: mTextStyle15(
                  //       mColor: Color(0xff032466), mFontWeight: FontWeight.w700),
                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SvgPicture.asset(
                      ImageString.jobPortalLogo,
                      height: 30,
                      // width: 40,
                      fit: BoxFit.contain,
                      allowDrawingOutsideViewBox: true, // optional
                    ),
                    // child: Image.asset(ImageString.pngLogo),
                  ),
                  mSpacer17(),
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: Text(
                      "Let's get started! ",
                      style: mTextStyle32(mColor: Color(0xff1A1C1E)),
                    ),
                  ),
                  SvgPicture.asset(ImageString.progressBar1),
                  mSpacer17(),

                  /// BODY PART
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "First Name",
                        style: mTextStyle14(),
                      )),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: Text(
                        "Last Name",
                        style: mTextStyle14(),
                      ))
                    ],
                  ),
                  mSpacer(mHeight: 2.0),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: firstnameController,
                          hintText: "Aman",
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'First name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: surnameController,
                          hintText: "Gupta",
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Last name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  mSpacer17(),

                  /// EMAIL TEXTFIELD
                  Text(
                    "Email",
                    style: mTextStyle14(),
                  ),
                  mSpacer(mHeight: 2.0),
                  CustomTextField(
                    controller: emailController,
                    hintText: "amangupta@gmail.com",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  mSpacer17(),

                  /// PHONE NUMBER TEXTFIELD
                  Text(
                    "Phone Number",
                    style: mTextStyle14(),
                  ),
                  CustomTextField(
                    controller: phoneController,
                    hintText: "",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone Number is required';
                      }
                      return null;
                    },
                  ),
                  mSpacer17(),

                  /// DATE OF BIRTH TEXTFIELD
                  Text(
                    "Date of Birth",
                    style: mTextStyle14(),
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now()
                            .subtract(const Duration(days: 365 * 40)),
                        firstDate: DateTime(1960),
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                        DOBController.text = formattedDate;
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: DOBController,
                        style: mTextStyle14(),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'DOB is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select your DOB",
                          hintStyle: mTextStyle14(
                            mFontWeight: FontWeight.w500,
                            mColor: const Color(0xffBCC1CA),
                          ),
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 18,
                            color: Color(0xffBCC1CA),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14), // match height
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xffBCC1CA)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xffBCC1CA)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(width: 1.5, color: Colors.red),
                          ),
                          errorStyle: const TextStyle(
                            fontSize: 12,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // CustomTextField(
                  //   controller: DOBController,
                  //   hintText: "",
                  //   suffixIcon: Icons.calendar_month_outlined,
                  //   onSuffixTap: () async {
                  //     DateTime? pickedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now()
                  //           .subtract(const Duration(days: 365 * 40)),
                  //       firstDate: DateTime(1960),
                  //       lastDate: DateTime.now(),
                  //     );
                  //     if (pickedDate != null) {
                  //       // Format the picked date (e.g., dd-MM-yyyy)
                  //       String formattedDate =
                  //           "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                  //       DOBController.text = formattedDate;
                  //     }
                  //   },
                  //   validator: (value) {
                  //     if (value == null || value.trim().isEmpty) {
                  //       return 'DOB is required';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  mSpacer17(),

                  /// CURRENT CITY TEXT FIELD
                  Text(
                    "Current City",
                    style: mTextStyle14(),
                  ),
                  // Text(
                  //   "Course",
                  //   style: mTextStyle14(),
                  // ),
                  CustomAutocomplete(
                    options: cities,
                    label: 'Current City',
                    onSelected: (value) {
                      selectedCurrentCity = value;

                      // showSnackbar('Selected $selectedCurrentCity', context);
                      developer.log(
                          'Selected Course variable : $selectedCurrentCity');
                    },
                  ),
                  // CustomTextField(
                  //   controller: cityController,
                  //   hintText: "",
                  //   validator: (value) {
                  //     if (value == null || value.trim().isEmpty) {
                  //       return 'Current City is required';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  mSpacer17(),

                  /// JOB LOCATION TEXTFIELD
                  Text(
                    "Preferred Job Location",
                    style: mTextStyle14(),
                  ),
                  CustomAutocomplete(
                    options: cities,
                    label: 'Preferred Job Location',
                    onSelected: (value) {
                      selectedPreferredCity = value;
                      // showSnackbar('Selected $selectedPreferredCity', context);
                      developer.log(
                          'Selected Course variable : $selectedPreferredCity');
                    },
                  ),
                  // CompositedTransformTarget(
                  //   link: _jobLocationLink,
                  //   child: CustomTextField(
                  //     key: _jobLocationFieldKey,
                  //     controller: JobLocationController,
                  //     hintText: "Select Preferred Job Location",
                  //     suffixIcon: Icons.keyboard_arrow_down_outlined,
                  //     onSuffixTap: () {
                  //       if (_jobLocationOverlayEntry == null) {
                  //         _showJobLocationDropdown();
                  //       } else {
                  //         _jobLocationOverlayEntry?.remove();
                  //         _jobLocationOverlayEntry = null;
                  //       }
                  //     },
                  //     validator: (value) {
                  //       if (value == null || value.trim().isEmpty) {
                  //         return 'Preferred Job Location is required';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  mSpacer17(),

                  /// GENDER TEXTFIELD
                  Text(
                    "Gender",
                    style: mTextStyle14(),
                  ),
                  CustomAutocomplete(
                    options: const ['Male', 'Female', 'other'],
                    label: 'Gender',
                    onSelected: (value) {
                      genderController.text = value;
                      // showSnackbar('Selected ${genderController.text}', context);
                      developer.log(
                          'Selected Course variable : ${genderController.text}');
                    },
                  ),
                  // CompositedTransformTarget(
                  //   link: _genderLayerLink,
                  //   child: Container(
                  //     key: _genderKey,
                  //     child: CustomTextField(
                  //       controller: genderController,
                  //       hintText: "",
                  //       suffixIcon: Icons.keyboard_arrow_down_outlined,
                  //       onSuffixTap: _toggleGenderDropdown,
                  //       validator: (value) {
                  //         if (value == null || value.trim().isEmpty) {
                  //           return 'Gender is required';
                  //         }
                  //         return null;
                  //       },
                  //     ),
                  //   ),
                  // ),
                  mSpacer17(),

                  /// USER TYPE
                  Text(
                    "Type",
                    style: mTextStyle14(),
                  ),
                  Wrap(
                    spacing: 12, // space between containers horizontally
                    runSpacing: 12, // space between lines
                    children: [
                      OptionContainer(
                        title: "School Student",
                        imgPath: "assets/Icons/school_student.svg",
                        // isSelected: selectedOption == "School Student",
                        isSelected:
                            selectedOption == JOBSEEKERTYPE.SchoolStudent.name,

                        onTap: () {
                          setState(() {
                            // selectedOption = "School Student";
                            selectedOption = JOBSEEKERTYPE.SchoolStudent.name;
                          });
                        },
                      ),
                      OptionContainer(
                        title: "College Student",
                        imgPath: "assets/Icons/College_Student.svg",
                        // isSelected: selectedOption == "College Student",
                        isSelected:
                            selectedOption == JOBSEEKERTYPE.CollegeStudent.name,
                        onTap: () {
                          setState(() {
                            // selectedOption = "College Student";
                            selectedOption = JOBSEEKERTYPE.CollegeStudent.name;
                          });
                        },
                      ),
                      OptionContainer(
                        title: "Fresher",
                        imgPath: "assets/Icons/fresher_icon.svg",
                        // isSelected: selectedOption == "Fresher",
                        isSelected:
                            selectedOption == JOBSEEKERTYPE.Fresher.name,
                        onTap: () {
                          setState(() {
                            // selectedOption = "Fresher";
                            selectedOption = JOBSEEKERTYPE.Fresher.name;
                          });
                        },
                      ),
                      OptionContainer(
                        title: "Working Professional",
                        imgPath: "assets/Icons/working-professional.svg",
                        // isSelected: selectedOption == "Working Professional",
                        isSelected: selectedOption ==
                            JOBSEEKERTYPE.WorkingProffesional.name,
                        onTap: () {
                          setState(() {
                            // selectedOption = "Working Professional";
                            selectedOption =
                                JOBSEEKERTYPE.WorkingProffesional.name;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  mSpacer(mHeight: 25.0),

                  /// FOR OPTION USER TYPE: SCHOOL STUDENT
                  if (selectedOption == JOBSEEKERTYPE.SchoolStudent.name)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Standard", style: mTextStyle12()),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing:
                              12, // horizontal spacing between OptionContainers
                          runSpacing: 8, // vertical spacing between rows
                          children: [
                            OptionContainer(
                              title: "Class XII",
                              imgPath: "",
                              isSelected: selectedClass == "Class XII",
                              onTap: () {
                                setState(() {
                                  selectedClass = "Class XII";
                                });
                              },
                            ),
                            OptionContainer(
                              title: "Class XI",
                              imgPath: "",
                              isSelected: selectedClass == "Class XI",
                              onTap: () {
                                setState(() {
                                  selectedClass = "Class XI";
                                });
                              },
                            ),
                            OptionContainer(
                              title: "Class X or below",
                              isSelected: selectedClass == "Class X or below",
                              onTap: () {
                                setState(() {
                                  selectedClass = "Class X or below";
                                });
                              },
                            ),
                          ],
                        ),
                        mSpacer(mHeight: 25.0),
                      ],
                    ),

                  /// FOR OPTION USER TYPE: COLLEGE STUDENT OR FRESHER
                  if (selectedOption == JOBSEEKERTYPE.CollegeStudent.name ||
                      selectedOption == JOBSEEKERTYPE.Fresher.name)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "Course",
                        //   style: mTextStyle14(),
                        // ),
                        const Padding(
                          padding: EdgeInsets.only(right: 11.0),
                          // child: BlocBuilder<CourseBloc, CourseState>(
                          //     builder: (context, state) {
                          //   if (state is CourseLoading) {
                          //     return CircularProgressIndicator();
                          //   } else if (state is CourseLoaded) {
                          //     return Wrap(
                          //       spacing: 8,
                          //       runSpacing: 8,
                          //       children: state.courses.map((course) {
                          //         return OptionContainer(
                          //           title: course.title,
                          //           isSelected: selectedCourse == course.title,
                          //           onTap: () {
                          //             setState(() {
                          //               selectedCourse = course.title;
                          //             });
                          //           },
                          //         );
                          //       }).toList(),
                          //     );
                          //   } else if (state is CourseError) {
                          //     return Text('Error: ${state.message}');
                          //   } else {
                          //     return SizedBox.shrink();
                          //   }
                          // },),
                        ),
                        // mSpacer(),

                        /// COLLEGES DETAILS
                        BlocBuilder<DetailedSignupBloc, DetailedSignupState>(
                          builder: (context, state) {
                            if (state
                                is DetailedSignupGetCollegeDetailsLoaded) {
                              final colleges = state.collegesListResponse;
                              final specializations =
                                  state.specializationListResponse;
                              final course = state.coursesListResponse;
                              developer.log('College list in ui : ${colleges}');
                              developer.log(
                                  "this is for specializatioooon ${specializations.specialization}");
                              developer
                                  .log("this is for courses ${course.courses}");
                              developer
                                  .log('Colleges data: ${colleges.toJson()}');
                              developer
                                  .log('Colleges list: ${colleges.colleges}');
                              developer.log('Courses data: ${course.toJson()}');
                              developer.log('Courses list: ${course.courses}');
                              developer.log(
                                  'Specializations data: ${specializations.toJson()}');
                              developer.log(
                                  'Specializations list: ${specializations.specialization}');
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Course",
                                    style: mTextStyle14(),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: course.courses.map((course) {
                                      final isSelected =
                                          selectedCourses.contains(course);
                                      return courseName(
                                        name: course,
                                        bgColor: isSelected
                                            ? const Color(0xff1961F3)
                                            : Colors.white,
                                        textColor: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        borderColor: isSelected
                                            ? const Color(0xff1961F3)
                                            : Colors.grey,
                                        onTap: () {
                                          setState(() {
                                            if (isSelected) {
                                              selectedCourses.remove(course);
                                            } else {
                                              selectedCourses.add(course);
                                            }
                                          });
                                        }, // optional or remove if unused
                                      );
                                    }).toList(),
                                  ),
                                  // Text(
                                  //   "Course",
                                  //   style: mTextStyle14(),
                                  // ),
                                  // CustomAutocomplete(
                                  //   options: course.courses,
                                  //   label: 'Course Names',
                                  //   onSelected: (value) {
                                  //     selectedCourse = value;
                                  //     showSnackbar(
                                  //         'Selected $selectedCourse', context);
                                  //     developer.log(
                                  //         'Selected Course variable : $selectedCourse');
                                  //   },
                                  // ),
                                  mSpacer(),
                                  Text(
                                    "College Name",
                                    style: mTextStyle14(),
                                  ),
                                  CustomAutocomplete(
                                    options: colleges.colleges,
                                    isLoading: state
                                        is DetailedSignupGetCollegeDetailsLoading,
                                    label: 'College Names',
                                    onSelected: (value) {
                                      showSnackbar('Selected $value', context);
                                      selectedCollege = value;
                                      developer.log(
                                          'Selected college variable : $selectedCollege');
                                    },
                                  ),
                                  mSpacer17(),
                                  Text(
                                    "Specialization",
                                    style: mTextStyle14(),
                                  ),
                                  CustomAutocomplete(
                                    options: specializations.specialization,
                                    label: 'Specialization Names',
                                    isLoading: state
                                        is DetailedSignupGetCollegeDetailsLoading,
                                    onSelected: (value) {
                                      selectedSpecialization = value;
                                      showSnackbar(
                                          'Selected $selectedSpecialization',
                                          context);
                                      developer.log(
                                          'Selected Specialization variable : $selectedSpecialization');
                                    },
                                  ),
                                ],
                              );
                            } else if (state
                                is DetailedSignupGetCollegeDetailsLoading) {
                              developer.log('State is Details Loading');
                              return const CircularProgressIndicator();
                            } else if (state
                                is DetailedSignupGetCollegeDetailsError) {
                              developer.log('Error in loading Details.');
                              return const Center(
                                child: Text(
                                    'There was some error in loading Details.'),
                              );
                            } else {
                              developer
                                  .log('Unhandeled state : of Load Details');
                              return const SizedBox();
                            }
                          },
                        ),

                        // mSpacer17(),

                        /// SPECIALIZATION DETAILS
                        // Text(
                        //   "Specialization",
                        //   style: mTextStyle14(),
                        // ),
                        // CompositedTransformTarget(
                        //   link: _specializationLayerLink,
                        //   child: CustomTextField(
                        //     key: _specializationKey,
                        //     controller: specializationController,
                        //     hintText: "Select Specialization",
                        //     suffixIcon: Icons.keyboard_arrow_down_outlined,
                        //     onSuffixTap: () {
                        //       if (_specializationOverlayEntry == null) {
                        //         _showSpecializationDropdown();
                        //       } else {
                        //         _specializationOverlayEntry?.remove();
                        //         _specializationOverlayEntry = null;
                        //       }
                        //     },
                        //   ),
                        // ),
                        mSpacer17(),

                        /// Start Year and End Year labels row
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Start Year",
                                  style: mTextStyle14(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "End Year",
                                  style: mTextStyle14(),
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// Small vertical space
                        mSpacer(mHeight: 2.0),

                        /// Start Year and End Year date picker fields
                        Row(
                          children: [
                            Expanded(
                              child: DatePickerField(
                                controller: startCourseYearController,
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: DatePickerField(
                                controller: endCourseYearController,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  /// COURSES OPTIONS
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Course",
                  //       style: mTextStyle14(),
                  //     ),
                  //     const Padding(
                  //       padding: EdgeInsets.only(right: 11.0),
                  //       // child: BlocBuilder<CourseBloc, CourseState>(
                  //       //     builder: (context, state) {
                  //       //   if (state is CourseLoading) {
                  //       //     return CircularProgressIndicator();
                  //       //   } else if (state is CourseLoaded) {
                  //       //     return Wrap(
                  //       //       spacing: 8,
                  //       //       runSpacing: 8,
                  //       //       children: state.courses.map((course) {
                  //       //         return OptionContainer(
                  //       //           title: course.title,
                  //       //           isSelected: selectedCourse == course.title,
                  //       //           onTap: () {
                  //       //             setState(() {
                  //       //               selectedCourse = course.title;
                  //       //             });
                  //       //           },
                  //       //         );
                  //       //       }).toList(),
                  //       //     );
                  //       //   } else if (state is CourseError) {
                  //       //     return Text('Error: ${state.message}');
                  //       //   } else {
                  //       //     return SizedBox.shrink();
                  //       //   }
                  //       // },),
                  //     ),
                  //     mSpacer(),
                  //     /// COLLEGES DETAILS
                  //     Text(
                  //       "College Name",
                  //       style: mTextStyle14(),
                  //     ),
                  //     CompositedTransformTarget(
                  //       link: _collegeLayerLink,
                  //       child: Container(
                  //         key: _collegeFieldKey,
                  //         child: CustomTextField(
                  //           controller: collegeController,
                  //           /// College Textfield
                  //           hintText: "College Name",
                  //           suffixIcon: Icons.keyboard_arrow_down_outlined,
                  //           onSuffixTap: () {
                  //             print("Suffix tapped");
                  //             if (_collegeOverLayEntry == null) {
                  //               _showDropdown();
                  //             } else {
                  //               _collegeOverLayEntry?.remove();
                  //               _collegeOverLayEntry = null;
                  //             }
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //     mSpacer17(),
                  //     /// SPECIALIZATION DETAILS
                  //     Text(
                  //       "Specialization",
                  //       style: mTextStyle14(),
                  //     ),
                  //     CompositedTransformTarget(
                  //       link: _specializationLayerLink,
                  //       child: CustomTextField(
                  //         key: _specializationKey,
                  //         controller: specializationController,
                  //         hintText: "Select Specialization",
                  //         suffixIcon: Icons.keyboard_arrow_down_outlined,
                  //         onSuffixTap: () {
                  //           if (_specializationOverlayEntry == null) {
                  //             _showSpecializationDropdown();
                  //           } else {
                  //             _specializationOverlayEntry?.remove();
                  //             _specializationOverlayEntry = null;
                  //           }
                  //         },
                  //       ),
                  //     ),
                  //     mSpacer17(),
                  //     Row(
                  //       /// Start year and end year text row
                  //       children: [
                  //         Text(
                  //           "Start Year",
                  //           style: mTextStyle14(),
                  //         ),
                  //         Spacer(),
                  //         Padding(
                  //           padding: const EdgeInsets.only(right: 100.0),
                  //           child: Text(
                  //             "End Year",
                  //             style: mTextStyle14(),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //     mSpacer(mHeight: 2.0),
                  //     ///  College Start year and End year textfield
                  //     Row(
                  //       children: [
                  //         SizedBox(
                  //           width: 160,
                  //           child: DatePickerField(
                  //               controller: startCourseYearController),
                  //         ),
                  //         Spacer(),
                  //         SizedBox(
                  //           width: 160,
                  //           child: DatePickerField(
                  //               controller: endCourseYearController),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),

                  /// WHEN USER TYPE : WORKING PROFESSIONAL
                  if (selectedOption == JOBSEEKERTYPE.WorkingProffesional.name)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // mSpacer(mHeight: 20.0),
                        Row(
                          children: [
                            Text(
                              "Total Work Experience ",
                              style: mTextStyle14(),
                            ),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),

                        /// Total Working experience textfield
                        CustomTextField(
                          controller: totalWorkExp,
                          hintText: "Select Experience",
                          suffixIcon: Icons.keyboard_arrow_down_outlined,
                        ),
                        mSpacer17(),
                        Row(
                          children: [
                            Text(
                              "Current Job Role",
                              style: mTextStyle14(),
                            ),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),

                        BlocBuilder<DetailedSignupBloc, DetailedSignupState>(
                          builder: (cntext, state) {
                            if (state
                                is DetailedSignupGetCollegeDetailsLoaded) {
                              final jobroles = state.jobrolesListResponse;
                              return CustomAutocomplete(
                                options: jobroles.jobroles,
                                label: 'Job Roles',
                                isLoading: state
                                    is DetailedSignupGetCollegeDetailsLoading,
                                onSelected: (value) {
                                  showSnackbar('Selected $value', context);
                                  developer.log(
                                      'Selected Job Roles variable : $value');
                                  selectedjobRole = value;
                                },
                              );
                            } else {
                              return Center(
                                child: Text('Unhandled state : $state'),
                              );
                            }
                          },
                        ),

                        /// Job role textfield
                        // CompositedTransformTarget(
                        //   link: _jobRoleLink,
                        //   child: Container(
                        //     key: _jobRoleFieldKey,
                        //     child: CustomTextField(
                        //       key: _jobRoleFieldKey,
                        //       controller: jobRoleController,
                        //       hintText: "Select Job Role",
                        //       suffixIcon: Icons.keyboard_arrow_down_outlined,
                        //       onSuffixTap: () {
                        //         print("Suffix icon tapped");
                        //         if (_jobRoleOverlayEntry == null) {
                        //           _showJobRoleDropdown();
                        //         } else {
                        //           _jobRoleOverlayEntry?.remove();
                        //           _jobRoleOverlayEntry = null;
                        //         }
                        //       },
                        //     ),
                        //   ),
                        // ),
                        mSpacer17(),
                        Row(
                          children: [
                            Text(
                              "Current Company",
                              style: mTextStyle14(),
                            ),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                        CustomTextField(
                          controller: currentCompany,

                          /// Current Company Textfield
                          hintText:
                              "Current Company", /*suffixIcon: Icons.keyboard_arrow_down_outlined,*/
                        ),
                        mSpacer17(),

                        /// Start year and end year columns
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Start Year",
                                  style: mTextStyle14(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "End Year",
                                  style: mTextStyle14(),
                                ),
                              ),
                            ),
                          ],
                        ),

                        mSpacer(mHeight: 2.0),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 160,
                                child: DatePickerField(
                                    controller: startJobYearController),
                              ),
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 160,
                                child: DatePickerField(
                                    controller: endJobYearController),
                              ),
                            ),
                          ],
                        ),
                        mSpacer17(),
                        Text(
                          "Current or Latest annual Salary/CTC ",
                          style: mTextStyle14(),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "We will use this to find jobs matching/ exceeding your  current salary range.This information is not visible to employers.",
                          style: TextStyle(fontSize: 11),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        CustomTextField(
                            controller: CTCController,
                            hintText: "E.g 4,00,000"),
                      ],
                    ),

                  mSpacer(mHeight: 25.0),

                  /// END PART
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      nextButton(
                        title: "Next",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            developer.log('Valid Form');
                            fillDataIntoParams();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPageYourSkills(
                                  params: widget.params,
                                ),
                              ),
                            );
                          } else {
                            showSnackbar('Please fill all the required fields.',
                                context);
                          }
                        },
                      ),
                    ],
                  ),
                  mSpacer(mHeight: 25.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void fillDataIntoParams() {
    // firstName: firstnameController.text,
    // surName: surnameController.text,
    // email: emailController.text,
    // phoneNumber: phoneController.text,
    // DOB: DOBController.text,
    // currentLocation: cityController.text,
    // jobPreferenceLocation: JobLocationController.text,
    // gender: genderController.text,
    // userCategory: selectedOption,
    // course: selectedCourse,
    // currentJobRole: jobRoleController.text,
    // CollegeName: collegeController.text,
    // Specialization: specializationController.text,
    // courseStartYear: startCourseYearController.text,
    // courseEndYear: endCourseYearController.text,
    // currentCompany: currentCompany.text,
    // jobStartYear: startJobYearController.text,
    // jobEndYear: endJobYearController.text,
    // studentClass: selectedClass,
    // totalWorkExp: totalWorkExp.text,
    final _prefs = sl<PreferencesManager>();

    widget.params.addAll({
      DETAILEDPROFILEPARAMS.user_id.name: _prefs.getuser_id() ?? '59',
      DETAILEDPROFILEPARAMS.first_name.name: firstnameController.text,
      DETAILEDPROFILEPARAMS.last_name.name: surnameController.text,
      DETAILEDPROFILEPARAMS.email.name: emailController.text,
      DETAILEDPROFILEPARAMS.phone.name: phoneController.text,
      DETAILEDPROFILEPARAMS.dob.name: formatDobToIso(DOBController.text),
      DETAILEDPROFILEPARAMS.city.name: cityController.text,
      DETAILEDPROFILEPARAMS.jobLocation.name: JobLocationController.text,
      DETAILEDPROFILEPARAMS.gender.name: genderController.text,
      DETAILEDPROFILEPARAMS.user_type.name: selectedOption,
      // total experience
    });

    // Remove all mutually exclusive keys first
    widget.params
      ..remove(DETAILEDPROFILEPARAMS.educationStandard.name)
      ..remove(DETAILEDPROFILEPARAMS.course.name)
      ..remove(DETAILEDPROFILEPARAMS.college_name.name)
      ..remove(DETAILEDPROFILEPARAMS.specialization.name)
      ..remove(DETAILEDPROFILEPARAMS.start_year.name)
      ..remove(DETAILEDPROFILEPARAMS.end_year.name)
      ..remove(DETAILEDPROFILEPARAMS.experiences.name);

    if (selectedOption == JOBSEEKERTYPE.SchoolStudent.name) {
      widget.params.addAll({
        DETAILEDPROFILEPARAMS.educationStandard.name: selectedClass,
      });
    } else if (selectedOption == JOBSEEKERTYPE.CollegeStudent.name ||
        selectedOption == JOBSEEKERTYPE.Fresher.name) {
      widget.params.addAll({
        DETAILEDPROFILEPARAMS.course.name: selectedCourse,
        DETAILEDPROFILEPARAMS.college_name.name: selectedCollege,
        DETAILEDPROFILEPARAMS.specialization.name: selectedSpecialization,
        DETAILEDPROFILEPARAMS.start_year.name: startCourseYearController.text,
        DETAILEDPROFILEPARAMS.end_year.name: endCourseYearController.text,
      });
    } else if (selectedOption == JOBSEEKERTYPE.WorkingProffesional.name) {
      widget.params.addAll({
        DETAILEDPROFILEPARAMS.experiences.name: [
          {
            DETAILEDPROFILEPARAMS.user_id.name: _prefs.getuser_id() ?? '59',
            // DETAILEDPROFILEPARAMS.companyRecruiterProfileId.name: 'x',
            DETAILEDPROFILEPARAMS.jobrole.name: selectedjobRole,
            DETAILEDPROFILEPARAMS.company.name: currentCompany.text,
            DETAILEDPROFILEPARAMS.start_date.name: startJobYearController.text,
            DETAILEDPROFILEPARAMS.end_date.name: endJobYearController.text,
          }
        ],
      });
    }

    developer
        .log('Params detials in sign up as anyone screen : ${widget.params}');
  }
}

/// Drop down for years
class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? fillColor;

  const DatePickerField({
    required this.controller,
    this.hintText = 'Select Date',
    super.key,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? Colors.transparent,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down,
          size: 18,
          color: Color(0xffBCC1CA),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1970),
          lastDate: DateTime(2100),
        );

        if (picked != null) {
          controller.text =
              '${picked.day} ${_monthName(picked.month)} ${picked.year}';
        }
      },
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }
}
