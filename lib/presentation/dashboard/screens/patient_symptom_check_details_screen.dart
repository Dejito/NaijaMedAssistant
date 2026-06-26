import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naija_med_assistant/core/utils/date_formatter.dart';

import '../../ai_chat/ai_chat_service/response/fetch_symptoms_history_response.dart';

class PatientSymptomCheckSummaryScreen extends StatelessWidget {
  final SymptomCheckItem symptomCheckItem;

  const PatientSymptomCheckSummaryScreen({
    super.key,
    required this.symptomCheckItem,
  });

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xff3b2eff);

    final joinedSymptoms = symptomCheckItem.symptoms?.join(', ') ?? 'None';

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
          'Detailed Summary',
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
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Symptom Checked Row
              _buildSummaryRow('Symptom Checked :', joinedSymptoms),
              const SizedBox(height: 16),

              // Date of Check Row (Fallback to empty string if null)
              _buildSummaryRow('Date of check:', DateTimeFormatter.formatTransactionDate(symptomCheckItem.createdAt ?? '') ?? ''),
              const SizedBox(height: 24),

              // AI Assessment Section
              const Text(
                'AI Assessment:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                symptomCheckItem.diagnosis ?? 'No assessment available.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 24),

              // Status Tag Row
              _buildSummaryRow('Status Tag:', symptomCheckItem.status ?? ''),
              const SizedBox(height: 48),

              // Action Buttons (Internal navigation handles the Back button now)
              SizedBox(
                width: 180,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Connect direct bloc/cubit action or routing here if needed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Report back to AI',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 110,
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, size: 18, color: Colors.white),
                  label: const Text(
                    'Back',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}