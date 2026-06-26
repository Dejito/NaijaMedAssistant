import 'package:flutter/material.dart';

import '../widgets/symptom_check_listview.dart';

class PatientHistoryScreen extends StatefulWidget {
  const PatientHistoryScreen({super.key});

  @override
  State<PatientHistoryScreen> createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  int _selectedTabIndex = 0; // 0 for Symptom Checker, 1 for AI Chats

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xff3b2eff);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
              children: [
                // Tab index 0: Displays your already implemented view assembly
                const SymptomCheckListview(),

                // Tab index 1: Placeholder layout container for AI Chats list widget
                _buildAiChatsListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Dummy layout for the right-hand view tab (AI Chats) shown in your screenshot
  Widget _buildAiChatsListView() {
    // Replace this structure entirely with your incoming chat response cubit/list-view
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade100),
          ),
          color: Colors.grey.shade50,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              index == 0 ? 'Conversation on Weight Loss' : 'Household remedy for Indigestion',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                index == 0 ? '3 Days Ago' : '5 Days Ago',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ),
            trailing: const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Open Chat',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
                ),
                Icon(Icons.chevron_right, size: 16, color: Colors.black),
              ],
            ),
            onTap: () {
              // TODO: Wire entry point routing target for explicit conversation threads
            },
          ),
        );
      },
    );
  }
}