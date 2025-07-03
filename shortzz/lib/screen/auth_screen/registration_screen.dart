// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shortzz/common/widget/custom_back_button.dart';
// import 'package:shortzz/common/widget/gradient_text.dart';
// import 'package:shortzz/common/widget/privacy_policy_text.dart';
// import 'package:shortzz/common/widget/text_button_custom.dart';
// import 'package:shortzz/common/widget/text_field_custom.dart';
// import 'package:shortzz/languages/languages_keys.dart';
// import 'package:shortzz/screen/auth_screen/auth_screen_controller.dart';
// import 'package:shortzz/utilities/style_res.dart';
// import 'package:shortzz/utilities/text_style_custom.dart';
// import 'package:shortzz/utilities/theme_res.dart';

// class RegistrationScreen extends StatelessWidget {
//   const RegistrationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AuthScreenController>();
//     return Scaffold(
//       body: SafeArea(

//         bottom: false,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//             const CustomBackButton(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
//             const SizedBox(height: 10),
//             Expanded(
//                 child: SingleChildScrollView(
//               dragStartBehavior: DragStartBehavior.down,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40, bottom: 30),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(LKey.signUp.tr.toUpperCase(),
//                             style: TextStyleCustom.unboundedBlack900(
//                               fontSize: 25,
//                               color: textDarkGrey(context),
//                             ).copyWith(letterSpacing: -.2)),
//                         GradientText(LKey.startJourney.tr.toUpperCase(),
//                             gradient: StyleRes.themeGradient,
//                             style: TextStyleCustom.unboundedBlack900(
//                               fontSize: 25,
//                               color: textDarkGrey(context),
//                             ).copyWith(letterSpacing: -.2)),
//                       ],
//                     ),
//                   ),
//                   TextFieldCustom(
//                     controller: controller.fullNameController,
//                     title: LKey.fullName.tr,
//                   ),
//                   TextFieldCustom(
//                     controller: controller.emailController,
//                     title: LKey.email.tr,
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   TextFieldCustom(
//                     controller: controller.passwordController,
//                     title: LKey.password.tr,
//                     isPasswordField: true,
//                   ),
//                   TextFieldCustom(
//                     controller: controller.confirmPassController,
//                     title: LKey.reTypePassword.tr,
//                     isPasswordField: true,
//                   ),
//                 ],
//               ),
//             )),
//             TextButtonCustom(
//                 onTap: controller.onCreateAccount,
//                 title: LKey.createAccount.tr,
//                 backgroundColor: textDarkGrey(context),
//                 horizontalMargin: 20,
//                 titleColor: whitePure(context)),
//             SizedBox(height: AppBar().preferredSize.height / 1.2),
//             const SafeArea(top: false, maintainBottomViewPadding: true, child: PrivacyPolicyText()),
//           ],
//         ),
//       ),
//     );
//   }
// }

// TopTap Registration Screen

import 'dart:io';
import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortzz/common/widget/custom_back_button.dart';
import 'package:shortzz/common/widget/gradient_text.dart';
import 'package:shortzz/common/widget/privacy_policy_text.dart';
import 'package:shortzz/common/widget/text_button_custom.dart';
import 'package:shortzz/common/widget/text_field_custom.dart';
import 'package:shortzz/common/widget/theme_blur_bg.dart';
import 'package:shortzz/languages/languages_keys.dart';
import 'package:shortzz/screen/auth_screen/auth_screen_controller.dart';
import 'package:shortzz/utilities/asset_res.dart';
import 'package:shortzz/utilities/color_res.dart';
import 'package:shortzz/utilities/style_res.dart';
import 'package:shortzz/utilities/text_style_custom.dart';
import 'package:shortzz/utilities/theme_res.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthScreenController>();

    return Scaffold(
      body: Stack(
        children: [
          const ThemeBlurBg(),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const CustomBackButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 5),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          LKey.createanAccount,
                          style: TextStyleCustom
                              .unboundedBlack900(
                            fontSize: 25,
                            color: whitePure(context),
                          ).copyWith(letterSpacing: -.2),
                        ),
                        const SizedBox(height: 10),
                        GradientText(
                          LKey.connectWithYourFriends,
                          // gradient: StyleRes.themeGradient,
                          gradient: LinearGradient(colors: [
                            whitePure(context)
                                .withValues(alpha: .5),
                            whitePure(context)
                          ]),
                          style: TextStyleCustom
                              .unboundedBlack900(
                            fontSize: 15,
                            color: whitePure(context),
                          ).copyWith(letterSpacing: -.2),
                        ),
                        const SizedBox(height: 40),

                        // Name
                        RegistrationSheetTextField(
                          controller:
                              controller.fullNameController,
                          title: LKey.fullName.tr,
                          hintText: LKey.fullName.tr,
                        ),
                        const SizedBox(height: 16),

                        // Email / Phone
                        RegistrationSheetTextField(
                          controller:
                              controller.emailController,
                          title: LKey.emailOrPhone.tr,
                          hintText:
                              LKey.enterEmailOrPhone.tr,
                          keyboardType:
                              TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        // Password
                        RegistrationSheetTextField(
                          controller:
                              controller.passwordController,
                          title: LKey.password.tr,
                          hintText: LKey.password.tr,
                          isPasswordField: true,
                        ),

                        // // Forgot Password
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Padding(
                        //     padding:
                        //         const EdgeInsets.symmetric(
                        //             vertical: 8.0),
                        //     child: InkWell(
                        //       onTap: () {
                        //         // Add forget password flow if needed
                        //       },
                        //       child: Text(
                        //         LKey.forgetPassword.tr,
                        //         style: TextStyleCustom
                        //             .outFitRegular400(
                        //           fontSize: 16,
                        //           color: whitePure(context),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(height: 40),

                        // Sign Up Button
                        TextButtonCustom(
                          onTap: controller.onCreateAccount,
                          title: LKey.signUp.tr,
                          backgroundColor:
                              ColorRes.themeGradient1,
                          horizontalMargin: 0,
                          titleColor: whitePure(context),
                        ),

                        const SizedBox(height: 30),

                        // Or With Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: whitePure(context),
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets
                                  .symmetric(
                                  horizontal: 12),
                              child: Text(
                                LKey.orWith.tr,
                                style: TextStyleCustom
                                    .outFitRegular400(
                                  fontSize: 16,
                                  color: whitePure(context),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: whitePure(context),
                                height: 1,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Social Buttons
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            // if (Platform.isIOS)
                            _socialIcon(AssetRes.icApple,
                                controller.onAppleTap),
                            //  if (Platform.isIOS)
                            const SizedBox(width: 12),
                            _socialIcon(AssetRes.icGoogle,
                                controller.onGoogleTap),
                            const SizedBox(width: 12),
                            _socialIcon(
                                AssetRes.icFacebook, () {}),
                          ],
                        ),

                        const SizedBox(height: 70),

                        // Already have account? Login
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: LKey
                                  .alreadyHaveAccount.tr,
                              style: TextStyleCustom
                                  .outFitRegular400(
                                color: whitePure(context),
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ${LKey.logIn.tr}',
                                  style: TextStyleCustom
                                      .outFitBold700(
                                    color:
                                        whitePure(context),
                                    fontSize: 16,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.back();
                                        },
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                const SafeArea(
                  top: false,
                  maintainBottomViewPadding: true,
                  child: PrivacyPolicyText(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(String iconPath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 57,
        width: 57,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            height: 28,
            width: 28,
          ),
        ),
      ),
    );
  }
}

class RegistrationSheetTextField extends StatefulWidget {
  final bool isPasswordField;
  final String? labelText;
  final String hintText;
  final String title;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const RegistrationSheetTextField({
    super.key,
    this.labelText,
    required this.title,
    this.isPasswordField = false,
    required this.hintText,
    required this.controller,
    this.keyboardType,
  });

  @override
  State<RegistrationSheetTextField> createState() =>
      _RegistrationSheetTextFieldState();
}

class _RegistrationSheetTextFieldState
    extends State<RegistrationSheetTextField> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 10,
            cornerSmoothing: 1,
          ),
          side: BorderSide(
            color: whitePure(context).withValues(alpha: .4),
          ),
          borderAlign: BorderAlign.inside,
        ),
        color: whitePure(context).withValues(alpha: .1),
      ),
      child: TextField(
        controller: widget.controller,
        style: TextStyleCustom.outFitRegular400(
          color: whitePure(context),
          fontSize: 16,
        ),
        onTapOutside: (event) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        obscureText: widget.isPasswordField && isHide,
        keyboardType:
            widget.keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyleCustom.outFitRegular400(
            color: whitePure(context),
            fontSize: 16,
          ),
          contentPadding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: widget.isPasswordField ? 2 : 0,
          ),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 48,
            minWidth: 48,
          ),
          suffixIcon: widget.isPasswordField
              ? InkWell(
                  onTap: () {
                    isHide = !isHide;
                    setState(() {});
                  },
                  child: AnimatedSwitcher(
                    duration:
                        const Duration(milliseconds: 250),
                    child: Image.asset(
                      isHide
                          ? AssetRes.icEye
                          : AssetRes.icHideEye,
                      height: 24,
                      width: 35,
                      color: whitePure(context),
                      key: UniqueKey(),
                    ),
                  ),
                )
              : null,
        ),
        cursorColor: whitePure(context),
      ),
    );
  }
}
