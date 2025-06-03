import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "elevated_bottom_button.dart";

// class DialogUtil {
//   static bool _isDialogShowing = false;
//
//   static Future<void> showSuccessfulDialog({
//     required BuildContext context,
//     required String subtitle,
//     required Function() onClick,
//   }) async {
//     if (_isDialogShowing) return;
//     _isDialogShowing = true;
//     await showGeneralDialog(
//       barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//       barrierDismissible: false,
//       transitionDuration: const Duration(milliseconds: 200),
//       context: context,
//       pageBuilder: (_, __, ___) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 50.w),
//           child: AlertDialog(
//             contentPadding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(12.r)),
//             ),
//             content: Container(
//               padding: EdgeInsets.only(top: 25.h, bottom: 24.h),
//               margin: EdgeInsets.symmetric(horizontal: 20.w),
//               width: 350.w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset(
//                     AppImages.successCheckmark,
//                     height: 60.h,
//                     width: 60.w,
//                     fit: BoxFit.scaleDown,
//                   ),
//                   titleText(
//                     text: "Success!",
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     bottomPadding: 15,
//                     topPadding: 25,
//                   ),
//                   titleText(
//                     text: subtitle,
//                     fontSize: 13,
//                     bottomPadding: 25,
//                     textAlign: TextAlign.center,
//                   ),
//                   BlackchinxBottomButton(
//                     text: "Okay",
//                     onPressed: () {
//                       DialogUtil.dismissDialog(context);
//                       onClick();
//                     },
//                     height: 45,
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (_, anim, __, child) {
//         return SlideTransition(
//           position: Tween(
//             begin: const Offset(1, 0),
//             end: const Offset(0, 0),
//           ).animate(anim),
//           child: child,
//         );
//       },
//     ).whenComplete(() => _isDialogShowing = false);
//   }
//
//   static Future<void> showSuccessfulDialogRichText({
//     required BuildContext context,
//     required String title,
//     required String subtitleFormatted,
//     required String subtitleUnformattedOne,
//     required String subtitleUnformattedTwo,
//     required Function() onClick,
//   }) async {
//     if (_isDialogShowing) return;
//     _isDialogShowing = true;
//     await showGeneralDialog(
//       barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//       barrierDismissible: false,
//       transitionDuration: const Duration(milliseconds: 200),
//       context: context,
//       pageBuilder: (_, __, ___) {
//         return Center(
//           // Use Center instead of Padding for full control
//           child: AlertDialog(
//             contentPadding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(12.r)),
//             ),
//             content: Container(
//               padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
//               width: 250.w, // Wider dialog
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: 12.h,
//                   ),
//                   Image.asset(
//                     AppImages.successCheckmark,
//                     height: 60.h,
//                     width: 60.w,
//                     fit: BoxFit.scaleDown,
//                   ),
//                   titleText(
//                     text: title,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     bottomPadding: 15,
//                     topPadding: 20,
//                   ),
//                   buildRichText(
//                     formattedText: " $subtitleFormatted",
//                     unformattedText: "$subtitleUnformattedOne ",
//                     unformattedText2: " $subtitleUnformattedTwo",
//                     formattedColor: Colors.black,
//                     formattedFontSize: 12,
//                     unformattedFontSize: 12
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   BlackchinxBottomButton(
//                     text: "Go to Dashboard",
//                     onPressed: () {
//                       DialogUtil.dismissDialog(context);
//                       onClick();
//                     },
//                     height: 48,
//                   ),
//                   SizedBox(height: 10.h),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (_, anim, __, child) {
//         return SlideTransition(
//           position: Tween(
//             begin: const Offset(1, 0),
//             end: const Offset(0, 0),
//           ).animate(anim),
//           child: child,
//         );
//       },
//     );
//   }
//
//   static void dismissDialog(BuildContext context) {
//     if (Navigator.canPop(context)) {
//       Navigator.pop(context);
//     }
//     _isDialogShowing = false;
//   }
// }
