import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:naija_med_assistant/core/constant/app_colors.dart';
import 'package:naija_med_assistant/core/constant/textfield_styles.dart';
import 'package:naija_med_assistant/presentation/user/user_service/req_body/update_doctor_req_body.dart';
import 'package:naija_med_assistant/presentation/user/user_service/response/get_doctor_response.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_cubit.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/get_doctor_states.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/update_doctor_states.dart';
import 'package:naija_med_assistant/presentation/utils/loading_indicator.dart';

import '../../../app_launch.dart';
import '../../auth/auth_views/auth_widgets.dart';
import '../../views/widgets/elevated_bottom_button.dart';
import '../../views/widgets/flutter_toast.dart';
import '../../views/widgets/text_input.dart';
import '../../views/widgets/titleText.dart';

class DoctorProfileSetup extends StatefulWidget {

  const DoctorProfileSetup({super.key});

  @override
  State<DoctorProfileSetup> createState() => _DoctorProfileSetupState();
}

class _DoctorProfileSetupState extends State<DoctorProfileSetup> {
  static const List<String> _genderOptions = ['Male', 'Female'];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _profileUrlController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _specializationController = TextEditingController();
  final TextEditingController _medicalRankController = TextEditingController();
  final TextEditingController _experienceYearsController = TextEditingController();
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _licenseExpiryDateController = TextEditingController();
  final TextEditingController _hospitalAffiliationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  String? _selectedGender;
  bool _hasHydratedForm = false;

  @override
  void initState() {
    super.initState();
    if (getIt.isRegistered<DoctorProfileResponse>()) {
      _hydrateForm(getIt<DoctorProfileResponse>());
    } else {
      getIt<UsersCubit>().getDoctorProfile();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dateOfBirthController.dispose();
    _genderController.dispose();
    _nationalityController.dispose();
    _profileUrlController.dispose();
    _ageController.dispose();
    _specializationController.dispose();
    _medicalRankController.dispose();
    _experienceYearsController.dispose();
    _licenseNumberController.dispose();
    _licenseExpiryDateController.dispose();
    _hospitalAffiliationController.dispose();
    _addressController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _hydrateForm(DoctorProfileResponse response) {
    if (_hasHydratedForm) {
      return;
    }

    final doctor = response.doctor;
    final user = doctor?.user;

    _firstNameController.text = user?.firstName ?? '';
    _lastNameController.text = user?.lastName ?? '';
    _emailController.text = user?.email ?? '';
    _phoneController.text = user?.phoneNumber ?? '';
    _dateOfBirthController.text = _normalizeDate(user?.dateOfBirth);
    _genderController.text = user?.gender ?? '';
    _nationalityController.text = user?.nationality ?? '';
    _profileUrlController.text = user?.profileUrl ?? '';
    _ageController.text = doctor?.age?.toString() ?? '';
    _specializationController.text = doctor?.specialization ?? '';
    _medicalRankController.text = doctor?.medicalRank ?? '';
    _experienceYearsController.text = doctor?.experienceYears?.toString() ?? '';
    _licenseNumberController.text = doctor?.licenseNumber ?? '';
    _licenseExpiryDateController.text = _normalizeDate(doctor?.licenseExpiryDate);
    _hospitalAffiliationController.text = doctor?.hospitalAffiliation ?? '';
    _addressController.text = doctor?.address ?? '';
    _stateController.text = doctor?.state ?? '';

    _selectedGender = _resolveOption(_genderController.text, _genderOptions);
    _hasHydratedForm = true;
  }

  String _normalizeDate(String? rawDate) {
    if (rawDate == null || rawDate.trim().isEmpty) {
      return '';
    }
    final parsedDate = DateTime.tryParse(rawDate);
    if (parsedDate == null) {
      return rawDate;
    }
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  String? _resolveOption(String? value, List<String> options) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final normalized = value.trim().toLowerCase();
    for (final option in options) {
      if (option.toLowerCase() == normalized) {
        return option;
      }
    }
    return null;
  }

  String? _valueOrNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  int? _parseIntOrNull(String value, {required String fieldName}) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return null;
    }

    final parsed = int.tryParse(trimmed);
    if (parsed == null) {
      showToast(message: 'Enter a valid $fieldName.');
    }
    return parsed;
  }

  Future<void> _pickDate(
    TextEditingController controller, {
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final initialDate = DateTime.tryParse(controller.text.trim()) ?? DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
    );

    if (selectedDate == null) {
      return;
    }
    controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  Widget _buildDropdownField({
    required String title,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText(title, fontWeight: FontWeight.w500),
          7.verticalSpace,
          DropdownButtonFormField<String>(
            initialValue: value,
            isExpanded: true,
            decoration: InputDecoration(
              hintText: 'Select $title',
              hintStyle: const TextStyle(color: Colors.grey),
              focusedBorder: AppStyles.focusedBorder,
              enabledBorder: AppStyles.focusBorder,
              border: AppStyles.focusBorder,
            ),
            items: options
                .map((option) => DropdownMenuItem<String>(value: option, child: Text(option)))
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  void _submitProfile() {
    if (_firstNameController.text.trim().isEmpty) {
      showToast(message: 'First name is required.');
      return;
    }
    if (_lastNameController.text.trim().isEmpty) {
      showToast(message: 'Last name is required.');
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      showToast(message: 'Phone number is required.');
      return;
    }

    final age = _parseIntOrNull(_ageController.text, fieldName: 'age');
    if (_ageController.text.trim().isNotEmpty && age == null) {
      return;
    }

    final experienceYears = _parseIntOrNull(
      _experienceYearsController.text,
      fieldName: 'years of experience',
    );
    if (_experienceYearsController.text.trim().isNotEmpty && experienceYears == null) {
      return;
    }

    final request = UpdateDoctorReqBody(
      firstName: _valueOrNull(_firstNameController.text),
      lastName: _valueOrNull(_lastNameController.text),
      phoneNumber: _valueOrNull(_phoneController.text),
      dateOfBirth: _valueOrNull(_dateOfBirthController.text),
      gender: _valueOrNull(_genderController.text),
      nationality: _valueOrNull(_nationalityController.text),
      profileUrl: _valueOrNull(_profileUrlController.text),
      age: age,
      specialization: _valueOrNull(_specializationController.text),
      medicalRank: _valueOrNull(_medicalRankController.text),
      experienceYears: experienceYears,
      licenseNumber: _valueOrNull(_licenseNumberController.text),
      licenseExpiryDate: _valueOrNull(_licenseExpiryDateController.text),
      hospitalAffiliation: _valueOrNull(_hospitalAffiliationController.text),
      address: _valueOrNull(_addressController.text),
      state: _valueOrNull(_stateController.text),
    );

    getIt<UsersCubit>().updateDoctor(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        title: titleText('Profile Set-up', fontSize: 16),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: Colors.grey,
            height: 2,
          ),
        ),
      ),
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: BlocConsumer<UsersCubit, UsersState>(
            bloc: getIt<UsersCubit>(),
            listener: (context, state) async {
              if (state is UpdateDoctorLoading) {
                showEaseLoadingIndicator();
              } else if (state is UpdateDoctorFailed) {
                dismissEaseLoadingIndicator();
                showToast(message: state.error ?? 'Unable to update profile. Please try again.');
              } else if (state is UpdateDoctorSuccessful) {
                dismissEaseLoadingIndicator();
                showToast(message: state.message ?? 'Profile updated successfully.');
                await getIt<UsersCubit>().getDoctorProfile();
              } else if (state is GetDoctorStateSuccessful) {
                _hydrateForm(state.user);
              } else if (state is GetDoctorStateFailed && !_hasHydratedForm) {
                showToast(message: state.error ?? 'Unable to load doctor profile.');
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileAvatar(),
                    Center(
                      child: titleText(
                        'Complete your doctor profile',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        bottomPadding: 20,
                      ),
                    ),
                    InputText(
                      title: 'First Name',
                      controller: _firstNameController,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Last Name',
                      controller: _lastNameController,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      enabled: false,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Phone Number',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Date of Birth',
                      controller: _dateOfBirthController,
                      readOnly: true,
                      onTap: () => _pickDate(
                        _dateOfBirthController,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                      bottomPadding: 16,
                    ),
                    _buildDropdownField(
                      title: 'Gender',
                      value: _selectedGender,
                      options: _genderOptions,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                          _genderController.text = value ?? '';
                        });
                      },
                    ),
                    InputText(
                      title: 'Nationality',
                      controller: _nationalityController,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Profile Image URL',
                      controller: _profileUrlController,
                      keyboardType: TextInputType.url,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Age',
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Specialization',
                      controller: _specializationController,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Medical Rank',
                      controller: _medicalRankController,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Years of Experience',
                      controller: _experienceYearsController,
                      keyboardType: TextInputType.number,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'License Number',
                      controller: _licenseNumberController,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'License Expiry Date',
                      controller: _licenseExpiryDateController,
                      readOnly: true,
                      onTap: () => _pickDate(
                        _licenseExpiryDateController,
                        firstDate: DateTime(2000),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Hospital Affiliation',
                      controller: _hospitalAffiliationController,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'Address',
                      controller: _addressController,
                      bottomPadding: 16,
                    ),
                    InputText(
                      title: 'State',
                      controller: _stateController,
                      bottomPadding: 0,
                    ),
                    MedBottomButton(
                      text: 'Save',
                      isLoading: state is UpdateDoctorLoading,
                      onPressed: _submitProfile,
                      topMargin: 30,
                      bottomMargin: 12,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}