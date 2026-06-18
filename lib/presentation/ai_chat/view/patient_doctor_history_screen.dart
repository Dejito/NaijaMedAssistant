import 'package:flutter/material.dart';
import 'package:naija_med_assistant/presentation/ai_chat/view/patient_history_details_screen.dart';

class PatientDoctorHistoryScreen extends StatefulWidget {
  static const route = '/history-list';

  const PatientDoctorHistoryScreen({super.key});

  @override
  State<PatientDoctorHistoryScreen> createState() => _PatientDoctorHistoryScreenState();
}

class _PatientDoctorHistoryScreenState extends State<PatientDoctorHistoryScreen> {
  // Mock dataset structured exactly like your interface mockups
  final List<DiagnosticHistoryItem> _historyItems = [
    DiagnosticHistoryItem(
      symptomsChecked: ["Fever", "Headache", "Nausea"],
      date: "13/10/2024",
      statusTag: "AI Resolved",
      assessment: "Based on the symptoms you reported, it is likely malaria. You should rest, stay hydrated, and monitor your temperature. Report back to us if symptoms persists.",
      suggestedNextSteps: [
        "Eat light meals",
        "Tepid sponge",
        "Stay Hydrated",
        "If symptoms persist after 24 hours, visit the nearest hospital to you or report back to us."
      ],
    ),
    DiagnosticHistoryItem(
      symptomsChecked: ["Fever", "Headache", "Nausea"],
      date: "13/10/2024",
      statusTag: "Flagged to Doctor",
      assessment: "Your high fever parameters fall outside normal ranges. We have connected your case directly to an available practitioner.",
      suggestedNextSteps: ["Await practitioner call", "Prepare medication records"],
    ),
    DiagnosticHistoryItem(
      symptomsChecked: ["Fever", "Headache", "Nausea"],
      date: "13/10/2024",
      statusTag: "AI Resolved",
      assessment: "Based on the symptoms you reported, it is likely malaria...",
      suggestedNextSteps: ["Eat light meals", "Tepid sponge"],
    ),
    DiagnosticHistoryItem(
      symptomsChecked: ["Fever", "Headache", "Nausea"],
      date: "13/10/2024",
      statusTag: "AI Resolved",
      assessment: "Based on the symptoms you reported, it is likely malaria...",
      suggestedNextSteps: ["Eat light meals", "Tepid sponge"],
    ),
    DiagnosticHistoryItem(
      symptomsChecked: ["Fever", "Headache", "Nausea"],
      date: "13/10/2024",
      statusTag: "AI Resolved",
      assessment: "Based on the symptoms you reported, it is likely malaria...",
      suggestedNextSteps: ["Eat light meals", "Tepid sponge"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: const Text(
          'History',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(color: Colors.grey.shade200, height: 1.5),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: _historyItems.length,
        itemBuilder: (context, index) {
          final item = _historyItems[index];
          return _buildHistoryCard(context, item, index);
        },
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, DiagnosticHistoryItem item, int index) {
    return Container(
      margin:  const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowData("Symptom Checked : ", item.symptomsString),
          const SizedBox(height: 8),
          _buildRowData("Date: ", item.date),
          const SizedBox(height: 8),
          _buildRowData("Status Tag: ", item.statusTag, isStatus: true),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                // Pass data matching selection index forward to the details panel
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedSummaryScreen(historyItem: item),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View Full Details",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF4D2CFA)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRowData(String label, String value, {bool isStatus = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: isStatus ? Colors.grey.shade600 : Colors.grey.shade500,
              fontWeight: isStatus ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}


class DiagnosticHistoryItem {
  final List<String> symptomsChecked;
  final String date;
  final String statusTag; // e.g., "AI Resolved", "Flagged to Doctor"
  final String assessment;
  final List<String> suggestedNextSteps;

  DiagnosticHistoryItem({
    required this.symptomsChecked,
    required this.date,
    required this.statusTag,
    required this.assessment,
    required this.suggestedNextSteps,
  });

  String get symptomsString => symptomsChecked.join(', ');
}