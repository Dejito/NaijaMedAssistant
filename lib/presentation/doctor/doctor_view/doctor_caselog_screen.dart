import 'package:flutter/material.dart';
import '../doctor_service/response/doctor_case_history_response.dart';
import 'doctor_case_summary_detail_screen.dart';

class DoctorCaseLogScreen extends StatelessWidget {

  final List<CaseLogItem> cases;

  const DoctorCaseLogScreen({Key? key, required this.cases}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          "Doctor's Case Log",
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
      body: cases.isEmpty
          ? const Center(child: Text("No logged cases found."))
          : ListView.separated(
        itemCount: cases.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black12),
        itemBuilder: (context, index) {
          final caseItem = cases[index];
          final patientUser = caseItem.patient?.user;
          final patientName = patientUser != null ? patientUser.fullName : "Unknown Patient";

          // Determine layout indicators based on case state or severity
          final isCritical = caseItem.isCritical;

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: CircleAvatar(
              backgroundColor: isCritical ? Colors.red.shade50 : Colors.green.shade50,
              child: Icon(
                isCritical ? Icons.warning_amber_rounded : Icons.check_circle,
                color: isCritical ? Colors.red : Colors.green,
              ),
            ),
            title: Text(
              patientName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                caseItem.status == 'assigned'
                    ? "Assigned case • Awaiting Review"
                    : "You have attended to this case",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CaseSummaryDetailScreen(caseItem: caseItem),
                ),
              );
            },
          );
        },
      ),
    );
  }
}