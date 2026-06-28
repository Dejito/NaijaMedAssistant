import 'package:flutter/material.dart';

import '../ai_chat/view/chat_with_ai_screen.dart';
import '../doctor/doctor_view/doctor_cases_screen.dart';
import '../doctor/doctor_view/doctor_dashboard.dart';
import '../user/users_view/profile_setup_doctor.dart';

class DoctorApplicationPage extends StatefulWidget {
  static const route = "/app-page";

  final bool preventPopFromBottomNav;

  const DoctorApplicationPage({
    super.key,
    this.preventPopFromBottomNav = true,
  });

  @override
  State<DoctorApplicationPage> createState() => _DoctorApplicationPageState();
}

class _DoctorApplicationPageState extends State<DoctorApplicationPage> {
  final List<Widget> _pages = [
    const DoctorDashboard(),
    const DoctorCasesScreen(),
    const ChatWithAiScreen(),
    const DoctorProfileSetup(),
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
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.home_outlined),
              ),
              label: "HOME",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.assignment_outlined), // Matches the "CASES" clipboard medical history outline icon
              ),
              label: "CASES",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.chat_bubble_outline), // Swap with your custom brand icon asset if using SVG
              ),
              label: "AI ASSISTANT",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Icon(Icons.person_outline),
              ),
              label: "PROFILE",
            ),
          ],        ),
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
