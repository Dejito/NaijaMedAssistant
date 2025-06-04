import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naija_med_assistant/presentation/views/chat/chat.dart';
import 'package:naija_med_assistant/presentation/views/profile/profile.dart';

import '../dashboard/dashboard.dart';


class ApplicationPage extends StatefulWidget {
  static const route = "/app-page";

  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  final List<Widget> _pages = [
    const Dashboard(),
    const Chat(),
    const Profile(),
  ];

  var selectedIndex = 0;

  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // color: selectedIndex == 1 ? const Color(0xFFFFD739) : Colors.white,
              ),
              label: "Wallet",
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     AppIcons.transaction,
            //     color: selectedIndex == 2 ? const Color(0xFFFFD739) : Colors.white,
            //   ),
            //   label: "Transactions",
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Account",
            ),
          ],
        ),
      ),
    );
  }
}
