import 'package:flutter/material.dart';
import 'package:naija_med_assistant/presentation/dashboard/screens/patient_chats_history_screen.dart';

import 'symptom_check_history_screen.dart';

class PatientHistoryTabView extends StatefulWidget {
  const PatientHistoryTabView({super.key});

  @override
  State<PatientHistoryTabView> createState() => _PatientHistoryTabViewState();
}

class _PatientHistoryTabViewState extends State<PatientHistoryTabView> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xff3b2eff);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // automaticallyImplyLeading: false,
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // Custom Pill Tab Switcher Container
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  // Tab 1: Symptom Checker
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTabIndex = 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 0 ? primaryBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Symptom Checker',
                          style: TextStyle(
                            color: _selectedTabIndex == 0 ? Colors.white : Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Tab 2: AI Chats
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTabIndex = 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 1 ? primaryBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'AI Chats',
                          style: TextStyle(
                            color: _selectedTabIndex == 1 ? Colors.white : Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Conditional View Area
          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children: const [
                // Tab index 0: Displays your already implemented view assembly
                SymptomCheckListview(),

                // Tab index 1: Placeholder layout container for AI Chats list widget
                PatientChatsHistoryScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Dummy layout for the right-hand view tab (AI Chats) shown in your screenshot
}