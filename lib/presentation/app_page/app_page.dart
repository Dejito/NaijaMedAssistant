import 'package:flutter/material.dart';
import 'package:naija_med_assistant/presentation/user/users_view/profile_setup_patient.dart';
import '../dashboard/screens/dashboard.dart';
import '../dashboard/screens/patient_history_tab_view.dart';


class ApplicationPage extends StatefulWidget {
  static const route = "/app-page";

  final bool preventPopFromBottomNav;

  const ApplicationPage({
    super.key,
    this.preventPopFromBottomNav = true,
  });

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  final List<Widget> _pages = [
    const Dashboard(),
    const PatientHistoryTabView(),
    const PatientProfileSetup(),
  ];

  var selectedIndex = 0;

  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF787878),
              Color(0xFF2A2A2A),
              Color(0xFF0E0E0E),
            ],
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: selectedPage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFFFD739),
          unselectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 13,
          iconSize: 27,
          backgroundColor: Colors.transparent,
          // Optional
          elevation: 0,
          // Optional, to let gradient show better
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble_outline,
              ),
              label: "Chat History",
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     AppIcons.transaction,
            //   ),
            //   label: "Transactions",
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profiles",
            ),
          ],
        ),
      ),
    );

    if (!widget.preventPopFromBottomNav) {
      return scaffold;
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        // Keep tab hosts from popping; move users to Home first.
        if (selectedIndex != 0) {
          setState(() {
            selectedIndex = 0;
          });
        }
      },
      child: scaffold,
    );
  }
}
