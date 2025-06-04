import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naija_med_assistant/core/constant/app_assets.dart';
import 'package:naija_med_assistant/presentation/views/dashboard/widgets/main_drawer.dart';
import 'package:naija_med_assistant/presentation/views/dashboard/widgets/symptom_check_listview.dart';

import '../../../../core/constant/app_colors.dart';
import '../../widgets/titleText.dart';
import '../widgets/dashboard_widgets.dart';

class Dashboard extends StatefulWidget {
  static const route = '/dashboard';

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final PageController _pageController;
  int swipeIndex = 0;

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
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40), // Make it circular again
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.logoWhite, height: 24, width: 24),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: titleText(
                  'CHAT WITH AI',
                  fontSize: 9,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
