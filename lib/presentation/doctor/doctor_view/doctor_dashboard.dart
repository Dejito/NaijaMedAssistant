
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/fetch_cases_response.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_viewmodel/doctor_cubit.dart';
import 'package:naija_med_assistant/presentation/user/user_service/response/get_doctor_response.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_viewmodel/doctor_module_states/fetch_cases_state.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/get_doctor_states.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../../app_launch.dart';
import '../../../core/constant/app_assets.dart';
import '../../../socket_manager/socket_manager.dart';
import '../../user/users_viewmodel/users_cubit.dart';
import '../../utils/dialogs.dart';
import '../../views/widgets/titleText.dart';
import 'widget/cases_listview_item.dart';

class DoctorDashboard extends StatefulWidget {

  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {

  late SocketManager _socketManager = SocketManager();
  DoctorProfileResponse user = DoctorProfileResponse();
  List<MedicalCase> _cases = const [];
  late final StreamSubscription<UsersState> _usersSubscription;
  late final StreamSubscription<DoctorState> _doctorSubscription;

  @override
  void initState() {

    super.initState();

    _socketManager = SocketManager();

    _socketManager.initialize();

    user = getIt.isRegistered<DoctorProfileResponse>()
        ? getIt<DoctorProfileResponse>()
        : DoctorProfileResponse();

    final existingCases =
        getIt.isRegistered<CasesResponse>() ? getIt<CasesResponse>().cases : null;
    _cases = existingCases ?? const [];

    // _showUpdateProfileDialogIfNeeded();

    _usersSubscription = getIt<UsersCubit>().stream.listen((state) {
      if (state is GetDoctorStateSuccessful && mounted) {
        setState(() {
          user = state.user;
        });
        // _showUpdateProfileDialogIfNeeded();

      }
    });

    _doctorSubscription = getIt<DoctorCubit>().stream.listen((state) {
      if (state is FetchCasesSuccessful && mounted) {
        setState(() {
          _cases = state.casesResponse.cases ?? const [];
        });
      }
    });

    getIt<UsersCubit>().getDoctorProfile();
    getIt<DoctorCubit>().fetchCases();

  }

  @override
  void dispose() {
    _usersSubscription.cancel();
    _doctorSubscription.cancel();
    super.dispose();
  }

  void _showUpdateProfileDialogIfNeeded() {
    final shouldShowDialog = user.doctor?.user?.profileCompleted != true;

    if (!mounted || !shouldShowDialog) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      DialogUtil.showUpdateProfileDialog(
        context: context,
        onClick: () async {
          if (!mounted) return;
          await context.push(AppRoutes.profileSetupDoctor);
          if (!mounted) return;

          await getIt<UsersCubit>().getDoctorProfile();
          if (!mounted) return;

          _showUpdateProfileDialogIfNeeded();
        },
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        centerTitle: true,
        title: titleText(
          'Home Page',
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              radius: 16.r,
              backgroundImage: const AssetImage(AppImages.userImage), // Doctor profile instance avatar
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(color: Colors.grey.shade200, height: 1.h),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Doctor Profile Greeting Banner Row ---
            Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  // border: Border.all(color: Colors.black54, width: 1),
                  backgroundImage: const AssetImage(AppImages.userImage),
                ),
                SizedBox(width: 12.w),
                Text(
                  "Welcome Dr. ${user.doctor?.user?.firstName ?? ""}",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 6.w),
                const Icon(Icons.check_circle, color: Colors.green, size: 18),
              ],
            ),
            SizedBox(height: 16.h),

            // --- 2. Interactive Availability Panel Card ---
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFD6E4FF), // Soft lavender blue variant framework color
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "You've attended to 5 Patient Today",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(Icons.notifications_none, color: Colors.black87),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "3 were Critical and 2 were Mild.",
                    style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 10.h),

                  // Open daily log feature navigation trigger button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D2CFA),
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                      elevation: 0,
                    ),
                    child: Text(
                      "OPEN DAILY CASE LOG",
                      style: TextStyle(fontSize: 10.sp, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Text(
                    "Kindly Confirm Your Availability:",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 8.h),

                  // Horizontal quick configuration actions rule matrix
                  Row(
                    children: [
                      _buildStatusActionButton("AVAILABLE NOW", const Color(0xFF1E7E34)),
                      SizedBox(width: 6.w),
                      _buildStatusActionButton("SCHEDULE ME FOR LATER", const Color(0xFF4D2CFA)),
                      SizedBox(width: 6.w),
                      _buildStatusActionButton("NOT AVAILABLE", const Color(0xFF4D2CFA)),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // --- 3. Queue List Section Header Navigation Link ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cases that requires your attention",
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                InkWell(
                  onTap: (){
                    context.push(AppRoutes.doctorCases);
                  },
                  child: Text(
                    "View more",
                    style: TextStyle(fontSize: 11.sp, color: const Color(0xFF4D2CFA), fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // --- 4. Cases Queue Frame Pipeline Block ---
            DoctorCasesList(
              cases: _cases,
              onViewPatientDetails: () {
                context.push(AppRoutes.caseSummaryScreen);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Quick Action Badge Generator
  Widget _buildStatusActionButton(String text, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 8.sp, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}
