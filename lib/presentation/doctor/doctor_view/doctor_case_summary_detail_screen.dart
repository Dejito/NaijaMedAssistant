import 'package:flutter/material.dart';

import '../doctor_service/response/doctor_case_history_response.dart';
// Replace this import path with where your data model actually lives

class CaseSummaryDetailScreen extends StatelessWidget {
  final CaseLogItem caseItem;

  const CaseSummaryDetailScreen({Key? key, required this.caseItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patient = caseItem.patient;
    final patientUser = patient?.user;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Case Summary",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Severity Tag Flag
            if (caseItem.severity != null)
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  decoration: BoxDecoration(
                    color: caseItem.isCritical ? Colors.red : Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    caseItem.severity!.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),

            // AI Assistant Header Segment
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.psychology, color: Colors.black54),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "AI Assistant",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "Summary Note for Doctor",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Patient Core Demographic Block
            _buildInfoRow("Name", patientUser?.fullName ?? "N/A"),
            _buildInfoRow("Genotype", patient?.genotype ?? "N/A"),

            _buildInfoRow("Chronic Conditions", patient?.chronicConditions ?? "None recorded"),
            _buildInfoRow("Current Medications", patient?.medications ?? "None recorded"),
            _buildInfoRow("Case Source", caseItem.source ?? "System Intake"),

            const SizedBox(height: 12),
            const Divider(color: Colors.black12),
            const SizedBox(height: 12),

            // Long Form Text Blocks
            const Text(
              "Presenting Symptoms",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              caseItem.symptoms ?? "No raw structural symptoms logged.",
              style: const TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
            ),

            const SizedBox(height: 20),
            const Text(
              "Patient Summary Note & Clinical Evaluation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              caseItem.aiSummary ?? "No clinical triage analysis notes compiled.",
              style: const TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
            ),

            const SizedBox(height: 20),
            const Text(
              "Initial Assessment / Diagnosis",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                caseItem.diagnosis ?? "Pending primary physician validation assessment.",
                style: const TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              "$label :",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}