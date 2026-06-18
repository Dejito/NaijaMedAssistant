import 'package:flutter/material.dart';
import 'package:naija_med_assistant/presentation/ai/view/patient_doctor_history_screen.dart';

class DetailedSummaryScreen extends StatelessWidget {

  final DiagnosticHistoryItem historyItem;

  const DetailedSummaryScreen({super.key, required this.historyItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detailed Summary',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(color: Colors.grey.shade200, height: 1.5),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Symptom Checked : ", historyItem.symptomsString),
            const SizedBox(height: 12),
            _buildDetailRow("Date of check: ", historyItem.date),
            const SizedBox(height: 16),

            const Text(
              "AI Assessment:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 6),
            Text(
              historyItem.assessment,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Suggested Next Steps :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 8),

            // Numbered ordered list rendering pipeline logic matching designs
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: historyItem.suggestedNextSteps.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1}. ",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Text(
                          historyItem.suggestedNextSteps[index],
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.3, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            _buildDetailRow("Status Tag:", historyItem.statusTag, isStatus: true),
            const SizedBox(height: 32),

            // Action Trigger Blue Pill Forms
            ElevatedButton(
              onPressed: () {
                // Return execution block back to core conversational loop
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4D2CFA),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text(
                "Report back to AI",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            const SizedBox(height: 14),

            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 16),
              label: const Text(
                "Back",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4D2CFA),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isStatus ? Colors.grey.shade600 : Colors.grey.shade500,
              fontWeight: isStatus ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}