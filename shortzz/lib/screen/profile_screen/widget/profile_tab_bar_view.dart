import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortzz/screen/profile_screen/profile_screen_controller.dart';
import 'package:shortzz/utilities/asset_res.dart';
import 'package:shortzz/utilities/theme_res.dart';

class ProfileTabs extends StatelessWidget {
  final ProfileScreenController controller;

  const ProfileTabs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    int tabcount = 5;
    return Column(
      children: [
        Obx(
          () => Stack(
            children: [
              Container(
                  height: .5,
                  color: textLightGrey(context)),
// Total number of tabs
              AnimatedAlign(
                alignment: Alignment(
                  (controller.selectedTabIndex.value /
                              (tabcount - 1)) *
                          2 -
                      1,
                  0,
                ),
                duration: const Duration(milliseconds: 300),
                child: Container(
                  height: 2,
                  width: Get.width / tabcount - 15,
                  color: themeAccentSolid(context),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10),
                ),
              ),

              // AnimatedAlign(
              //   alignment: AlignmentDirectional
              //           .centerStart +
              //       AlignmentDirectional(
              //           (controller.selectedTabIndex.value *
              //                       2 -
              //                   6) /
              //               6.0,
              //           0),
              //   duration: const Duration(milliseconds: 300),
              //   child: Container(
              //     height: 1,
              //     width: Get.width / 6 - 15,
              //     color: themeAccentSolid(context),
              //     margin: const EdgeInsets.symmetric(
              //         horizontal: 10),
              //   ),
              // ),
            ],
          ),
        ),
        TabBar(
          onTap: (value) {
            controller.userData.value?.checkIsBlocked(
              () {
                controller.onTabChanged(value);
                controller.pageController.animateToPage(
                  value,
                  duration:
                      const Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              },
            );
          },
          isScrollable: true,
          indicatorColor: themeAccentSolid(context),
          indicatorWeight: 2.0,
          //  indicatorColor: Colors.transparent,
          tabs: List.generate(
            5,
            (index) {
              final icons = [
                AssetRes.icReel,
                AssetRes.icPost,
                AssetRes.icLock,
                AssetRes.icHeart1,
                AssetRes.icSave,
              ];
              return Obx(() {
                final color =
                    controller.selectedTabIndex.value ==
                            index
                        ? themeAccentSolid(context)
                        : disableGrey(context);
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0),
                  child: Image.asset(icons[index],
                      height: 40, width: 30, color: color),
                );
              });
            },
          ),
        ),
        Container(
            height: .5, color: textLightGrey(context)),
      ],
    );
  }
}

// original code

// class ProfileTabs extends StatelessWidget {
//   final ProfileScreenController controller;

//   const ProfileTabs({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Obx(
//           () => Stack(
//             children: [
//               Container(height: .5, color: textLightGrey(context)),
//               AnimatedAlign(
//                 alignment: controller.selectedTabIndex.value == 1
//                     ? AlignmentDirectional.centerEnd
//                     : AlignmentDirectional.centerStart,
//                 duration: const Duration(milliseconds: 300),
//                 child: Container(
//                   height: 1,
//                   width: Get.width / 2 - 80,
//                   color: themeAccentSolid(context),
//                   margin: const EdgeInsets.symmetric(horizontal: 40),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         TabBar(
//             onTap: (value) {
//               controller.userData.value?.checkIsBlocked(() {
//                 controller.onTabChanged(value);
//               controller.pageController.animateToPage(value,
//                   duration: const Duration(milliseconds: 300), curve: Curves.linear);
//               });
//             },
//             indicatorColor: Colors.transparent,
//             tabs: List.generate(2, (index) {
//               final icon = index == 0 ? AssetRes.icReel : AssetRes.icPost;
//               return Obx(() {
//                 final color = controller.selectedTabIndex.value == index
//                     ? themeAccentSolid(context)
//                     : disableGrey(context);
//                 return Image.asset(icon, height: 50, width: 35, color: color);
//               });
//             })),
//         Container(height: .5, color: textLightGrey(context)),
//       ],
//     );
//   }
// }
