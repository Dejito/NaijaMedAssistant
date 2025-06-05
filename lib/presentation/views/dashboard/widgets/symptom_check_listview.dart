import 'package:flutter/material.dart';
import 'package:naija_med_assistant/presentation/views/dashboard/widgets/dashboard_widgets.dart';

class SymptomCheckListview extends StatelessWidget {
  const SymptomCheckListview({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (context, i) {
            return symptomCheckHistoryItem(symptomCheckHistory[i]);
          },
          itemCount: symptomCheckHistory.length,
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}

class SymptomCheckHistory {

  final String symptomChecked;
  final String date;
  final String status;

  SymptomCheckHistory(
      {required this.symptomChecked, required this.date, required this.status,});

}

List<SymptomCheckHistory> symptomCheckHistory = [
  SymptomCheckHistory(
    symptomChecked: 'Fever, Headache, Nausea',
    date: '13/06/2024',
    status: 'AI Resolved',),
  SymptomCheckHistory(
    symptomChecked: 'Fever, Headache, Nausea',
    date: '13/06/2024',
    status: 'Doctor Resolved',),
  SymptomCheckHistory(
    symptomChecked: 'Fever, Headache, Nausea',
    date: '13/06/2024',
    status: 'Doctor Resolved',),
  SymptomCheckHistory(
    symptomChecked: 'Fever, Headache, Nausea',
    date: '13/06/2024',
    status: 'AI Resolved',),

];
