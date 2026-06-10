import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionItem {
  String medication;
  String dosage;
  String duration;

  PrescriptionItem({
    this.medication = '',
    this.dosage = '',
    this.duration = '',
  });
}

class CreatePrescriptionScreen extends StatefulWidget {
  const CreatePrescriptionScreen({super.key});

  @override
  State<CreatePrescriptionScreen> createState() => _CreatePrescriptionScreenState();
}

class _CreatePrescriptionScreenState extends State<CreatePrescriptionScreen> {
  // Setup standard dynamic rows matching the mockup layout state
  final List<PrescriptionItem> _items = [
    PrescriptionItem(medication: 'Lonart', dosage: '2 times daily', duration: '3 Days'),
    PrescriptionItem(medication: 'PCM', dosage: '3 times daily', duration: '3 Days'),
    PrescriptionItem(medication: 'Septrin', dosage: '2 times daily', duration: '3 Days'),
    PrescriptionItem(medication: '', dosage: '', duration: ''), // Triggers the "Add More" UI state row
  ];

  void _addNewRow() {
    setState(() {
      // Insert new row right before the final interactive row or append
      _items.add(PrescriptionItem());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Prescription',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(color: Colors.grey.shade300, height: 1.h),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Timestamp Banner Block ---
              Center(
                child: Text(
                  '13/10/2024',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // --- Case Summary Demographics Info Matrix ---
              _buildCaseSummaryRow('Presenting Complaint : ', 'Fever, Headache, Nausea'),
              _buildCaseSummaryRow('Diagnosis : ', 'Malaria'),
              _buildCaseSummaryRow('Allergy : ', 'None'),
              _buildCaseSummaryRow('Past Medical History : ', 'None'),
              _buildCaseSummaryRow('Current Medication : ', 'None'),
              _buildCaseSummaryRow('Case Category : ', 'Moderate'),
              SizedBox(height: 32.h),

              // --- Form Identifier Label Tag ---
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87, width: 0.8),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'Create Prescription',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // --- Interactive Medication Dynamic Grid Container ---
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 1.w),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    final isLastRow = index == _items.length - 1;

                    return Row(
                      children: [
                        // Row Index Serial Label
                        SizedBox(
                          width: 22.w,
                          child: Text(
                            '${index + 1}.',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        // Medication Input Column
                        Expanded(
                          child: _buildGridInputField(
                            value: item.medication,
                            hint: 'Add More',
                            isActionTrigger: isLastRow,
                            onChanged: (val) => item.medication = val,
                            onTap: isLastRow ? _addNewRow : null,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Dosage Rule Input Column
                        Expanded(
                          child: _buildGridInputField(
                            value: item.dosage,
                            hint: 'Add More',
                            isActionTrigger: isLastRow,
                            onChanged: (val) => item.dosage = val,
                            onTap: isLastRow ? _addNewRow : null,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Duration Cycle Input Column
                        Expanded(
                          child: _buildGridInputField(
                            value: item.duration,
                            hint: 'Add More',
                            isActionTrigger: isLastRow,
                            onChanged: (val) => item.duration = val,
                            onTap: isLastRow ? _addNewRow : null,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 40.h),

              // --- Operational Pipeline Action Row Layout ---
              GestureDetector(
                onTap: () {
                  // TODO: Secure endpoint payload delivery integration pipeline
                },
                child: Container(
                  width: 190.w,
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D2CFA),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Send Prescription',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        radius: 10.r,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 12.w,
                          color: const Color(0xFF4D2CFA),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 150.w,
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D2CFA),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 10.r,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_back,
                          size: 12.w,
                          color: const Color(0xFF4D2CFA),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Back to Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Demographic Info Structural Row Generator ---
  Widget _buildCaseSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 13.5.sp, color: Colors.grey.shade700),
          children: [
            TextSpan(
              text: label,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  // --- Cell Input Layout Decorator Engine ---
  Widget _buildGridInputField({
    required String value,
    required String hint,
    required bool isActionTrigger,
    required ValueChanged<String> onChanged,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400, width: 0.8.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        alignment: Alignment.center,
        child: isActionTrigger
            ? Text(
          hint,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        )
            : TextFormField(
          initialValue: value,
          textAlign: TextAlign.center,
          onChanged: onChanged,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}