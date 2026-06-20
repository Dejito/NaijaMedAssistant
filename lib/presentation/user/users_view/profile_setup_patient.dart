import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/core/constant/app_colors.dart';

import '../../views/widgets/elevated_bottom_button.dart';
import '../../views/widgets/text_input.dart';
import '../../views/widgets/titleText.dart';
import '../../auth/auth_views/auth_widgets.dart';

class PatientProfileSetup extends StatelessWidget {

  static const route = '/profile-setup';

  PatientProfileSetup({super.key});

  final TextEditingController nameController = TextEditingController(text: 'Ogunrinde Blessing');
  final TextEditingController emailController = TextEditingController(text: 'Bogunride22@gmail.com');
  final TextEditingController phoneController = TextEditingController(text: '08102394672');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // elevation: 1,
        backgroundColor: AppColors.white,
        title: titleText('Profile Set-up', fontSize: 16),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: Colors.grey,
            height: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            profileAvatar(),
            InputText(
              hint: "",
              controller: nameController,
              bottomPadding: 0,
            ),
            InputText(
              controller: emailController,
              hint: "",
              bottomPadding: 0,
            ),
            InputText(
              controller: phoneController,
              hint: "",
              bottomPadding: 0,
            ),
            InputText(
              // controller: ,
              hint: "Home Address",
              bottomPadding: 0,
            ),
            InputText(
              hint: "Date of Birth",
              bottomPadding: 0,
            ),
            InputText(
              hint: "Gender",
              bottomPadding: 0,
            ),
            InputText(
              hint: "Nationality",
              bottomPadding: 0,
            ),
            InputText(

              hint: "Blood Group",
              bottomPadding: 0,
            ),
            InputText(
              hint: "Heigth",
              bottomPadding: 0,
            ),
            InputText(
              hint: "Weight",
              bottomPadding: 0,
            ),
            InputText(
              hint: "BMI",
              bottomPadding: 0,
            ),
            MedBottomButton(
              text: "Save",
              onPressed: () {
                context.pop();
              },
              topMargin: 30,
              bottomMargin: 12,
            ),
          ],
        ),
      ),
    );
  }
}
