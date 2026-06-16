import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/dashboard/widgets/main_drawer.dart';
import 'package:naija_med_assistant/presentation/dashboard/widgets/symptom_check_listview.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../router/route.dart';
import '../../../data/models/response/users/get_user_response.dart';
import '../../views/widgets/titleText.dart';
import '../widgets/dashboard_widgets.dart';

class Dashboard extends StatefulWidget {

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late final PageController _pageController;
  int swipeIndex = 0;

  PatientUserResponse userResponse = PatientUserResponse();


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // elevation: 1,
        backgroundColor: AppColors.white,
        title: titleText(
          'Home',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: Colors.grey,
            height: 2,
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                )),
            child: const Icon(Icons.person),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dashboardWelcomeBar(),
            quickActionsCardSlider(
              context: context,
              controller: _pageController,
              index: swipeIndex.toDouble(),
              onSwipe: (value) {
                setState(() {
                  swipeIndex = value;
                });
              },
            ),
            viewMoreSymptoms(),
            const Expanded(child: SymptomCheckListview(),)

          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            context.push(AppRoutes.chatWithAi);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: fabContent()
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
