import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/presentation/views/dashboard/widgets/main_drawer.dart';

import '../../../core/constant/app_colors.dart';
import '../widgets/titleText.dart';
import 'widgets/dashboard_widgets.dart';

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
        title: titleText('Profile Set-up', fontSize: 16),
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
            symptomCheckHistoryItem(),

          ],
        ),
      ),
    );
  }
}
