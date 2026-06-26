import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/dashboard/widgets/main_drawer.dart';
import 'package:naija_med_assistant/presentation/dashboard/widgets/symptom_check_listview.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_cubit.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/get_patient_states.dart';
import 'package:naija_med_assistant/presentation/utils/dialogs.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../router/route.dart';
import '../../../app_launch.dart';
import '../../user/user_service/response/get_patient_response.dart';
import '../../../socket_manager/socket_manager.dart';
import '../../views/widgets/titleText.dart';
import '../widgets/dashboard_widgets.dart';

class Dashboard extends StatefulWidget {

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late SocketManager _socketManager = SocketManager();

  late final PageController _pageController;
  late final StreamSubscription<UsersState> _usersSubscription;

  int swipeIndex = 0;

  PatientUserResponse userResponse = PatientUserResponse();

  @override
  void initState() {

    super.initState();

    _socketManager = SocketManager();

    _socketManager.initialize();

    userResponse = getIt.isRegistered<PatientUserResponse>()
        ? getIt<PatientUserResponse>()
        : PatientUserResponse();

    _showUpdateProfileDialogIfNeeded();

    _usersSubscription = getIt<UsersCubit>().stream.listen((state) {
      if (state is GetPatientStateSuccessful && mounted) {
        setState(() {
          userResponse = state.user;
        });
        _showUpdateProfileDialogIfNeeded();
      }
    });

    getIt<UsersCubit>().getPatientProfile();


    _pageController = PageController();
  }

  void _showUpdateProfileDialogIfNeeded() {
    final shouldShowDialog = userResponse.patient?.user?.profileCompleted != true;

    if (!mounted || !shouldShowDialog) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      DialogUtil.showUpdateProfileDialog(
        context: context,
        onClick: () async {
          if (!mounted) return;
          await context.push(AppRoutes.profileSetup);
          if (!mounted) return;

          await getIt<UsersCubit>().getPatientProfile();
          if (!mounted) return;

          _showUpdateProfileDialogIfNeeded();
        },
      );
    });
  }

  @override
  void dispose() {
    _usersSubscription.cancel();
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
            dashboardWelcomeBar(userResponse.patient?.user?.firstName ?? ""),
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
            viewMoreSymptoms((){

            }),
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
