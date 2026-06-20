import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/core/constant/app_assets.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../views/widgets/elevated_bottom_button.dart';
import '../../views/widgets/text_input.dart';
import '../../views/widgets/titleText.dart';

class DoctorProfileSetup extends StatelessWidget {
  static const route = '/profile-setup-doctor';

  DoctorProfileSetup({super.key});

  // Empty by default as requested
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController rankController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController workplaceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.home_outlined, color: Colors.black87),
        //   onPressed: () => context.go(AppRoutes.dashboard),
        // ),
        title: titleText('Profile Set-up', fontSize: 16, fontWeight: FontWeight.bold),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.5.h),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.5.h,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instruction Heading
            Center(
              child: Text(
                "Kindly complete your profile set-up",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Profile Avatar Stack Component with camera badge overlay
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 110.w,
                    height: 110.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(AppImages.userImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 2.w,
                    bottom: 2.h,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black87, width: 1.2),
                      ),
                      child: Icon(Icons.camera_alt_outlined, size: 16.w, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // --- Form fields utilizing your custom InputText widget singly ---
            InputText(
              title: "Full Name (include title)",
              controller: nameController,
              bottomPadding: 16,
            ),
            InputText(
              title: "Email Address",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              bottomPadding: 16,
            ),
            InputText(
              title: "Phone",
              controller: phoneController,
              keyboardType: TextInputType.phone,
              bottomPadding: 16,
            ),
            InputText(
              title: "Age",
              controller: ageController,
              keyboardType: TextInputType.number,
              bottomPadding: 16,
            ),
            InputText(
              title: "Medical Specialty",
              controller: specialtyController,
              bottomPadding: 16,
            ),
            InputText(
              title: "Date Of Birth",
              controller: dobController,
              bottomPadding: 16,
            ),
            InputText(
              title: "Gender",
              controller: genderController,
              bottomPadding: 16,
            ),
            InputText(
              title: "Nationality",
              controller: nationalityController,
              bottomPadding: 16,
            ),
            InputText(
              title: "Medical Rank",
              controller: rankController,
              bottomPadding: 16,
            ),
            InputText(
              title: "Years of Experience",
              controller: experienceController,
              bottomPadding: 16,
            ),
            InputText(
              title: "License Number",
              controller: licenseController,
              bottomPadding: 16,
            ),
            InputText(
              title: "Country of Practice",
              controller: countryController,
              bottomPadding: 16,
            ),
            InputText(
              title: "Place Of Work",
              controller: workplaceController,
              bottomPadding: 16,
            ),

            // --- Certificate Attachment Widget Block ---
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "License Certificate here",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      // File picker implementation
                    },
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: const Color(0xFF4D2CFA),
                      size: 28.w,
                    ),
                  ),
                ],
              ),
            ),

            // Persistent Save Execution Component
            MedBottomButton(
              text: "Save",
              onPressed: () {
                context.go(AppRoutes.login);
              },
              topMargin: 20.h,
              bottomMargin: 24.h,
            ),
          ],
        ),
      ),
    );
  }
}