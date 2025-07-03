// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shortzz/common/widget/custom_shimmer_fill_text.dart';
// import 'package:shortzz/common/widget/theme_blur_bg.dart';
// import 'package:shortzz/screen/splash_screen/splash_screen_controller.dart';
// import 'package:shortzz/utilities/app_res.dart';
// import 'package:shortzz/utilities/text_style_custom.dart';
// import 'package:shortzz/utilities/theme_res.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(SplashScreenController());
//     return Scaffold(
//       body: Stack(
//         children: [
//           //  const ThemeBlurBg(),
//           Align(
//             alignment: Alignment.center,
//             child: CustomShimmerFillText(
//               text: AppRes.appName.toUpperCase(),
//               baseColor: whitePure(context),
//               textStyle: TextStyleCustom.unboundedBlack900(
//                   color: whitePure(context), fontSize: 30),
//               finalColor: whitePure(context),
//               shimmerColor: themeAccentSolid(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortzz/common/widget/custom_shimmer_fill_text.dart';
import 'package:shortzz/common/widget/theme_blur_bg.dart';
import 'package:shortzz/screen/splash_screen/splash_screen_controller.dart';
import 'package:shortzz/utilities/app_res.dart';
import 'package:shortzz/utilities/text_style_custom.dart';
import 'package:shortzz/utilities/theme_res.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());

    return Scaffold(
      //backgroundColor: Color(0xFFE6ECEF),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Optional: Add background blur or color here
          //const ThemeBlurBg(),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  //  'assets/images/Toptap_logo.png',
                  // ensure this path is correct in pubspec.yaml
                  'assets/videos/Toptap_logo.png',
                  //'assets/videos/TopTap.gif',
                  // width: double.infinity,
                  // height: double.infinity,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24),
                CustomShimmerFillText(
                  text: AppRes.appName.toUpperCase(),
                  baseColor: whitePure(context),
                  duration: const Duration(seconds: 7),
                  textStyle:
                      TextStyleCustom.unboundedBlack900(
                    color: whitePure(context),
                    fontSize: 30,
                  ),
                  finalColor: whitePure(context),
                  shimmerColor: themeAccentSolid(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
