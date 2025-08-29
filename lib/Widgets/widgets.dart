import 'dart:async';
import 'dart:developer' as developer show log;
import 'dart:math' as Math;
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_portal/utils/constants/image_string.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import '../UI_Helper/UI_Helper.dart';

/// CUSTOMIZED APPBAR

PreferredSizeWidget buildCustomAppBar({required String titleText}) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        titleText,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: "Inter",
          fontWeight: FontWeight.w700,
          color: TColors.primary,
        ),
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("assets/Icons/message_icon.svg"),
        padding: const EdgeInsets.only(right: 20.0),
      ),
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("assets/Icons/notifications_icon.svg"),
        padding: const EdgeInsets.only(right: 20.0),
      ),
    ],
  );
}

/// HEADING PART WIDGET
Widget signInHeader({required VoidCallback onTap}) {
  return Container(
    height: 180,
    width: double.infinity,
    decoration: BoxDecoration(color: TColors.primary),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  mSpacer(),
          Container(
            height: 113,
            width: 327,
            child: Text(
              "Sign in to your Account",
              style: mTextStyle32(),
            ),
          ),
          mSpacer(mHeight: 10.0),
          Row(
            children: [
              Text(
                "Don't have an account? ",
                style: mTextStyle14(mColor: Colors.white),
              ),
              InkWell(
                onTap: onTap,
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: TColors.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red, // underline color
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

/// FORGET PASSWORD ROW
// Widget forgetPassRow(
//     {required VoidCallback ontap, required VoidCallback onTapRemMe}) {
//   return Row(
//     children: [
//       Container(
//         height: 11.08,
//         width: 11.08,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(2),
//             border: Border.all(color: Color(0xff6C7278), width: 1)),
//       ),
//       SizedBox(
//         width: 6.0,
//       ),
//       Text(
//         "Remember me",
//         style: mTextStyle14(),
//       ),
//       Spacer(),
//       InkWell(
//           onTap: ontap,
//           child: Text(
//             "Forgot Password?",
//             style: mTextStyle14(
//                 mColor: AppColors.blueTextColor, mFontWeight: FontWeight.w600),
//           )),
//     ],
//   );
// }

class RememberMeRow extends StatefulWidget {
  final VoidCallback onForgotPasswordTap;
  final ValueChanged<bool> onRememberMeChanged;

  const RememberMeRow({
    super.key,
    required this.onForgotPasswordTap,
    required this.onRememberMeChanged,
  });

  @override
  State<RememberMeRow> createState() => _RememberMeRowState();
}

class _RememberMeRowState extends State<RememberMeRow> {
  bool isChecked = true;

  void _toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onRememberMeChanged(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    final checkedColor = TColors.primary;
    // final checkedColor = Theme.of(context).colorScheme.primary;
    return Row(
      children: [
        GestureDetector(
          onTap: _toggleCheckbox,
          child: Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                  color: isChecked ? checkedColor : const Color(0xff6C7278),
                  width: 1),
              color: isChecked ? checkedColor : Colors.transparent,
            ),
            child: isChecked
                ? const Icon(Icons.check, size: 12, color: Colors.white)
                : null,
          ),
        ),
        const SizedBox(width: 6.0),
        GestureDetector(
          onTap: _toggleCheckbox,
          child: Text(
            "Remember me",
            style: mTextStyle14(),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: widget.onForgotPasswordTap,
          child: Text(
            "Forgot Password?",
            style: mTextStyle14(
              mColor: AppColors.blueTextColor,
              mFontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

/// COMMON CONTAINER WIDGET
Widget commonRedContainer({required String text, VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: TColors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Text(
        text,
        style: mTextStyle14(mColor: Colors.white),
      )),
    ),
  );
}

/// DIVIDER LINE
Widget dividerLine() {
  return Row(
    children: [
      Expanded(
          child: Divider(
        thickness: 1,
        color: Colors.grey[400],
        endIndent: 10,
      )),
      Text(
        "OR",
        style: mTextStyle14(mColor: Colors.grey.shade500),
      ),
      Expanded(
        child: Divider(
          thickness: 1,
          color: Colors.grey[400],
          indent: 10,
        ),
      ),
    ],
  );
}

/// BELOW BARS
Widget belowBars({required String text, String? imgUrl, VoidCallback? onTap}) {
  return Container(
    height: 48,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 217, 218, 223),
          // color: Colors.grey.shade500,
        )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (imgUrl != null) ...[
          Container(
            height: 18,
            width: 18,
            child: SvgPicture.asset(
              "assets/Icons/google.svg",
              height: 18,
              width: 18,
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
        InkWell(
            onTap: onTap,
            child: Text(
              text,
              style: mTextStyle14(mFontWeight: FontWeight.w600),
            ))
      ],
    ),
  );
}

/// CUSTOM TEXTFIELDS
// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final String? labelText;
//   final IconData? prefixIcon;
//   final IconData? suffixIcon;
//   final bool obscureText;
//   final TextInputType? keyboardType;
//   final VoidCallback? onSuffixTap;
//   final String? Function(String?)? validator;
//   final Color? fillColor;

//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     this.labelText,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.keyboardType,
//     this.onSuffixTap,
//     this.obscureText = false,
//     this.validator,
//     this.fillColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(
//           controller: controller,
//           obscureText: obscureText,
//           keyboardType: keyboardType,
//           validator: validator,
//           style: mTextStyle14(),
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: fillColor ?? Colors.white,
//             hintText: hintText,
//             labelText: labelText,
//             hintStyle: mTextStyle14(
//               mFontWeight: FontWeight.w500,
//               mColor: const Color(0xffBCC1CA),
//             ),
//             prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
//             suffixIcon: suffixIcon != null
//                 ? GestureDetector(
//                     onTap: onSuffixTap,
//                     child: Icon(
//                       suffixIcon,
//                       size: 20,
//                       color: const Color(0xffBCC1CA),
//                     ),
//                   )
//                 : null,
//             contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16, vertical: 14), // maintain height
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(width: 1, color: Color(0xffBCC1CA)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(width: 1, color: Color(0xffBCC1CA)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:
//                   BorderSide(width: 1.5, color: Theme.of(context).primaryColor),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(width: 1, color: Colors.red),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(width: 1.5, color: Colors.red),
//             ),
//             errorStyle: const TextStyle(
//               fontSize: 12,
//               height: 1.0, // Control line height
//             ),
//           ),
//         ),
//         // const SizedBox(height: 12), // spacing between fields
//       ],
//     );
//   }
// }

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final bool isPasswordField;
  final TextInputType? keyboardType;
  final VoidCallback? onSuffixTap;
  final String? Function(String?)? validator;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.isPasswordField = false,
    this.onSuffixTap,
    this.validator,
    this.fillColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: mTextStyle14(),
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor ?? Colors.white,
            hintText: widget.hintText,
            labelText: widget.labelText,
            hintStyle: mTextStyle14(
              mFontWeight: FontWeight.w500,
              mColor: const Color(0xffBCC1CA),
            ),
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            suffixIcon: widget.suffixIcon != null
                ? GestureDetector(
                    onTap: () {
                      if (widget.isPasswordField) {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      }
                      widget.onSuffixTap?.call();
                    },
                    child: Icon(
                      widget.isPasswordField
                          ? (_obscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility)
                          : widget.suffixIcon,
                      size: 20,
                      color: const Color(0xffBCC1CA),
                    ),
                  )
                : null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Color(0xffBCC1CA)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Color(0xffBCC1CA)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(width: 1.5, color: Theme.of(context).primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}

/// TEXTFILEDS

TextEditingController paymentCardController = TextEditingController();
TextEditingController CVVController = TextEditingController();
TextEditingController ValidUptoController = TextEditingController();
TextEditingController ticketController = TextEditingController();
TextEditingController InternshipProfileController = TextEditingController();
TextEditingController SkillsRequiredController = TextEditingController();
TextEditingController responsibilitiesController = TextEditingController();
TextEditingController preferencesController = TextEditingController();
TextEditingController no_openingController = TextEditingController();
TextEditingController minStipendController = TextEditingController();
TextEditingController minIncentivesController = TextEditingController();
TextEditingController maxStipendController = TextEditingController();
TextEditingController maxIncentivesController = TextEditingController();
TextEditingController alterPhoneController = TextEditingController();
TextEditingController startDateController = TextEditingController();
TextEditingController endDateController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController internshipDurationController = TextEditingController();
TextEditingController internshipDurationMonthsController =
    TextEditingController();
TextEditingController minSalaryController = TextEditingController();
TextEditingController maxSalaryController = TextEditingController();
TextEditingController recruiterNameController = TextEditingController();
TextEditingController recruiter_SurNameController = TextEditingController();
TextEditingController newPassController = TextEditingController();
TextEditingController courseCollegeController = TextEditingController();

///  OPTION CONTAINER (For any kind of option like courses option, user-type option)
Widget OptionContainer(
    {required String title,
    bool isSelected = false,
    VoidCallback? onTap,
    String? imgPath,
    IconData? mIcon}) {
  final hasImg = imgPath != null && imgPath.isNotEmpty;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      //  height: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.69),
          border: Border.all(
              color: Colors.grey.shade400 /*Color(0xffEDF1F3,)*/, width: 1.0),
          color: isSelected == true ? Color(0xff1961F3) : Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              hasImg ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 14,
                width: 12,
                child: SvgPicture.asset(
                  imgPath ?? "",
                  color: isSelected == true ? Colors.white : Colors.black,
                ), /*color:isSelected==true?Colors.white:Colors.black*/
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    color: isSelected == true ? Colors.white : Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(
                mIcon,
                size: 10,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

/// NEXT BUTTON AT THE BOTTOM
Widget nextButton({required String title, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 40,
      width: 110,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: TColors.secondary),
      child: Center(
          child: Text(
        title,
        style: mTextStyle14(mColor: Colors.white),
      )),
    ),
  );
}

/// SIZEBOX OF HEIGHT 17
Widget mSpacer17() {
  return SizedBox(
    height: 17,
  );
}

/// PREFERENCE CONTAINER
Widget preferenceContainer({
  required String cName,
  String? fileName,
  IconData? cIcon,
  required VoidCallback onTap,
  required TextEditingController courseCollegeController,
  Color? bgColor,
  List<String>? subSkills,
  List<String>? selectedSubSkills,
  final String? Function(String?)? validator,
  void Function(String skill)? onSkillTap,
  void Function()? onUploadCertificateTap,
  void Function()? onCrossTap,
}) {
  int fileNameLength = 0;
  if (fileName != null) {
    fileNameLength = Math.min(fileName!.length, 15);
  }
  // final certiColor = Color.fromARGB(255, 205, 207, 216);

  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffBCC1CA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              courseName(
                name: cName,
                bgColor: const Color(0xff1961F3),
                // mIcon: cIcon,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
                onCrossTap: onCrossTap,
              ),
              const Spacer(),
              fileName == null
                  ? courseName(
                      name: "Upload Certificate", onTap: onUploadCertificateTap)
                  : SizedBox(),
              // image seleted
              fileName != null
                  ? InkWell(
                      onTap: onUploadCertificateTap,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 205, 207, 216)),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  ImageString.certificate,
                                  color: Color.fromARGB(255, 108, 114, 120),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                // const Icon(Icons.image),
                                Text(
                                  fileName.substring(0, fileNameLength),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 108, 114, 120),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )
                  : const SizedBox(),
              // const SizedBox(width: 5),
              // Padding(
              //   padding: const EdgeInsets.only(right: 5.0),
              //   child: InkWell(
              //     onTap: () {},
              //     child: SvgPicture.asset("assets/Icons/doubt_icon.svg"),
              //   ),
              // )
            ],
          ),
          const SizedBox(height: 7),
          Text("Where did you learn this skill?", style: mTextStyle12()),
          const SizedBox(height: 8),
          CustomTextField(
            controller: courseCollegeController,
            hintText: "College/Company Name",
            fillColor: Colors.white,
            validator: validator,
          ),
          const SizedBox(height: 8),
          Text("Related skills you might know", style: mTextStyle12()),
          const SizedBox(height: 10),
          if (subSkills != null && subSkills.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: subSkills.map((skill) {
                final isSelected = selectedSubSkills?.contains(skill) ?? false;
                return GestureDetector(
                  onTap: () => onSkillTap?.call(skill),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff1961F3)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xff1961F3)
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          subSkills == null
              ? courseName(name: "See More", mIcon: Icons.add)
              : const SizedBox(),
        ],
      ),
    ),
  );
}

/// Widget for course names

Widget courseName({
  required String name,
  IconData? mIcon,
  Icon? icon,
  Color? bgColor,
  Color? textColor,
  Color? borderColor,
  VoidCallback? onTap,
  VoidCallback? onCrossTap,
}) {
  final Color background = bgColor ?? Colors.grey[300]!; // Default grey
  final bool isDefaultGrey = background == Colors.grey[300];
  final Color finalTextColor =
      textColor ?? (isDefaultGrey ? Colors.black : Colors.white);

  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: borderColor ?? const Color(0xffEFF0F6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 13, color: finalTextColor),
          ),
          if (mIcon != null) ...[
            const SizedBox(width: 6),
            Icon(
              mIcon,
              size: 12,
              color: finalTextColor,
            ),
          ],
          icon != null
              ? InkWell(
                  onTap: onCrossTap,
                  child: icon,
                )
              : const SizedBox()
        ],
      ),
    ),
  );
}

ScaffoldFeatureController showSnackbar(String message, BuildContext context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}

class CustomAutocomplete extends StatefulWidget {
  final List<String> options;
  final String label;
  final void Function(String) onSelected;

  const CustomAutocomplete({
    super.key,
    required this.options,
    required this.label,
    required this.onSelected,
  }) ;

  @override
  State<CustomAutocomplete> createState() => _CustomAutocompleteState();
}

class _CustomAutocompleteState extends State<CustomAutocomplete> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // developer.log('Colleges in autocomplete : ${widget.options}');
    return Container(
      // color: Colors.white,
      child: Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        padding: const EdgeInsets.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return RawAutocomplete<String>(
                  textEditingController: _controller,
                  focusNode: _focusNode,
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    final input = textEditingValue.text.toLowerCase().trim();
                    // Show all options if field is focused but empty
                    if (input.isEmpty && _focusNode.hasFocus) {
                      return widget.options;
                    }
                    return widget.options.where(
                        (option) => option.toLowerCase().contains(input));
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 8.0,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth,
                            maxHeight:
                                250, // Limit height to make it scrollable
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final String option = options.elementAt(index);
                              return InkWell(
                                onTap: () => onSelected(option),
                                borderRadius: BorderRadius.circular(8),
                                child: ListTile(
                                  title: Text(option),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  onSelected: widget.onSelected,
                  fieldViewBuilder: (
                    context,
                    controller,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        isDense: true,
                        hintText: widget.label,
                        hintStyle: mTextStyle14(
                          mFontWeight: FontWeight.w500,
                          mColor: const Color(0xffBCC1CA),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14), // maintain height
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
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xffBCC1CA),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;

  const CustomPhoneField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: IntlPhoneField(
        flagsButtonPadding: const EdgeInsets.all(9),
        dropdownIconPosition: IconPosition.trailing,
        showDropdownIcon: true,
        dropdownIcon: const Icon(Icons.keyboard_arrow_down),
        initialCountryCode: 'IN',
        onChanged: (phone) {
          controller.text = phone.number;
        },
        decoration: InputDecoration(
          hintText: '7895674320',
          hintStyle: const TextStyle(color: Color(0xffBCC1CA)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Color(0xffBCC1CA)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Color(0xffBCC1CA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(width: 1.5, color: Theme.of(context).primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1.5, color: Colors.red),
          ),
          errorStyle: const TextStyle(
            fontSize: 12,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}

class SearchTextField extends StatefulWidget {
  final Function(String) onTextChanged;

  const SearchTextField({Key? key, required this.onTextChanged})
      : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}





class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      widget.onTextChanged(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 11,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: Color(0xFFBCC1CA),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              // Add your filter tap logic here
              print("Filter tapped");
            },
            child: SvgPicture.asset(
              ImageString.searchicon,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
