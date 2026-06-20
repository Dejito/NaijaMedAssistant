import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:naija_med_assistant/core/constant/app_colors.dart';
import 'package:naija_med_assistant/presentation/user/user_service/req_body/update_patient_req_body.dart';
import 'package:naija_med_assistant/presentation/user/user_service/response/get_patient_response.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_cubit.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/get_patient_states.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/update_patient_states.dart';
import 'package:naija_med_assistant/presentation/utils/loading_indicator.dart';

import '../../../app_launch.dart';
import '../../views/widgets/elevated_bottom_button.dart';
import '../../views/widgets/flutter_toast.dart';
import '../../views/widgets/text_input.dart';
import '../../views/widgets/titleText.dart';
import '../../auth/auth_views/auth_widgets.dart';

class PatientProfileSetup extends StatefulWidget {
  static const route = '/profile-setup';

  const PatientProfileSetup({super.key});

  @override
  State<PatientProfileSetup> createState() => _PatientProfileSetupState();
}

class _PatientProfileSetupState extends State<PatientProfileSetup> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _lgaController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _genotypeController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _chronicConditionsController = TextEditingController();
  final TextEditingController _medicationsController = TextEditingController();
  final TextEditingController _emergencyContactNameController = TextEditingController();
  final TextEditingController _emergencyContactPhoneController = TextEditingController();
  final TextEditingController _emergencyContactRelationshipController = TextEditingController();
  final TextEditingController _nextOfKinNameController = TextEditingController();
  final TextEditingController _nextOfKinPhoneController = TextEditingController();
  final TextEditingController _nextOfKinRelationshipController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();

  bool _hasHydratedForm = false;

  @override
  void initState() {
    super.initState();
    _heightController.addListener(_updateBmi);
    _weightController.addListener(_updateBmi);

    if (getIt.isRegistered<PatientUserResponse>()) {
      _hydrateForm(getIt<PatientUserResponse>());
    } else {
      getIt<UsersCubit>().getPatientProfile();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dateOfBirthController.dispose();
    _genderController.dispose();
    _stateController.dispose();
    _lgaController.dispose();
    _bloodGroupController.dispose();
    _genotypeController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _allergiesController.dispose();
    _chronicConditionsController.dispose();
    _medicationsController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactPhoneController.dispose();
    _emergencyContactRelationshipController.dispose();
    _nextOfKinNameController.dispose();
    _nextOfKinPhoneController.dispose();
    _nextOfKinRelationshipController.dispose();
    _bmiController.dispose();
    super.dispose();
  }

  void _hydrateForm(PatientUserResponse response) {
    if (_hasHydratedForm) {
      return;
    }

    final patient = response.patient;
    final user = patient?.user;

    _firstNameController.text = user?.firstName ?? '';
    _lastNameController.text = user?.lastName ?? '';
    _emailController.text = user?.email ?? '';
    _phoneController.text = user?.phoneNumber ?? '';
    _addressController.text = patient?.address ?? '';
    _dateOfBirthController.text = _normalizeDate(user?.dateOfBirth);
    _genderController.text = user?.gender ?? '';
    _stateController.text = patient?.state ?? '';
    _lgaController.text = patient?.lga ?? '';
    _bloodGroupController.text = patient?.bloodGroup ?? '';
    _genotypeController.text = patient?.genotype ?? '';
    _heightController.text = patient?.height?.toString() ?? '';
    _weightController.text = patient?.weight?.toString() ?? '';
    _allergiesController.text = patient?.allergies ?? '';
    _chronicConditionsController.text = patient?.chronicConditions ?? '';
    _medicationsController.text = patient?.medications ?? '';
    _emergencyContactNameController.text = patient?.emergencyContactName ?? '';
    _emergencyContactPhoneController.text = patient?.emergencyContactPhone ?? '';
    _emergencyContactRelationshipController.text = patient?.emergencyContactRelationship ?? '';
    _nextOfKinNameController.text = patient?.nextOfKinName ?? '';
    _nextOfKinPhoneController.text = patient?.nextOfKinPhone ?? '';
    _nextOfKinRelationshipController.text = patient?.nextOfKinRelationship ?? '';
    _bmiController.text = patient?.bmi?.toStringAsFixed(1) ?? '';

    _hasHydratedForm = true;
    _updateBmi();
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

  void _updateBmi() {
    final height = double.tryParse(_heightController.text.trim());
    final weight = double.tryParse(_weightController.text.trim());

    if (height == null || height <= 0 || weight == null || weight <= 0) {
      if (_bmiController.text.isNotEmpty) {
        _bmiController.text = '';
      }
      return;
    }

    final normalizedHeightInMeters = height > 3 ? height / 100 : height;
    if (normalizedHeightInMeters <= 0) {
      _bmiController.text = '';
      return;
    }

    final bmi = weight / (normalizedHeightInMeters * normalizedHeightInMeters);
    final formattedBmi = bmi.toStringAsFixed(1);

    if (_bmiController.text != formattedBmi) {
      _bmiController.text = formattedBmi;
    }
  }

  String? _valueOrNull(String value) {
    final trimmedValue = value.trim();
    return trimmedValue.isEmpty ? null : trimmedValue;
  }

  num? _parseNumberOrNull(String value, {required String fieldName}) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return null;
    }

    final parsedValue = num.tryParse(trimmedValue);
    if (parsedValue == null) {
      showToast(message: 'Enter a valid $fieldName.');
    }

    return parsedValue;
  }

  Future<void> _pickDateOfBirth() async {
    final initialDate = DateTime.tryParse(_dateOfBirthController.text.trim()) ?? DateTime(2000);
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    _dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
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

    final height = _parseNumberOrNull(_heightController.text, fieldName: 'height');
    if (_heightController.text.trim().isNotEmpty && height == null) {
      return;
    }

    final weight = _parseNumberOrNull(_weightController.text, fieldName: 'weight');
    if (_weightController.text.trim().isNotEmpty && weight == null) {
      return;
    }

    final request = UpdatePatientReqBody(
      firstName: _valueOrNull(_firstNameController.text),
      lastName: _valueOrNull(_lastNameController.text),
      phoneNumber: _valueOrNull(_phoneController.text),
      dateOfBirth: _valueOrNull(_dateOfBirthController.text),
      gender: _valueOrNull(_genderController.text),
      address: _valueOrNull(_addressController.text),
      state: _valueOrNull(_stateController.text),
      lga: _valueOrNull(_lgaController.text),
      bloodGroup: _valueOrNull(_bloodGroupController.text),
      genotype: _valueOrNull(_genotypeController.text),
      height: height,
      weight: weight,
      allergies: _valueOrNull(_allergiesController.text),
      chronicConditions: _valueOrNull(_chronicConditionsController.text),
      medications: _valueOrNull(_medicationsController.text),
      emergencyContactName: _valueOrNull(_emergencyContactNameController.text),
      emergencyContactPhone: _valueOrNull(_emergencyContactPhoneController.text),
      emergencyContactRelationship: _valueOrNull(_emergencyContactRelationshipController.text),
      nextOfKinName: _valueOrNull(_nextOfKinNameController.text),
      nextOfKinPhone: _valueOrNull(_nextOfKinPhoneController.text),
      nextOfKinRelationship: _valueOrNull(_nextOfKinRelationshipController.text),
    );

    getIt<UsersCubit>().updatePatient(request);
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
      body: SafeArea(
        child: BlocConsumer<UsersCubit, UsersState>(
          bloc: getIt<UsersCubit>(),
          listener: (context, state) async {
            if (state is UpdatePatientLoading) {
              showEaseLoadingIndicator();
            } else if (state is UpdatePatientFailed) {
              dismissEaseLoadingIndicator();
              showToast(message: state.error ?? 'Unable to update profile. Please try again.');
            } else if (state is UpdatePatientSuccessful) {
              dismissEaseLoadingIndicator();
              showToast(message: state.message ?? 'Profile updated successfully.');
              await getIt<UsersCubit>().getPatientProfile();
              if (!context.mounted) {
                return;
              }
              context.pop();
            } else if (state is GetPatientStateSuccessful) {
              _hydrateForm(state.user);
            } else if (state is GetPatientStateFailed && !_hasHydratedForm) {
              showToast(message: state.error ?? 'Unable to load patient profile.');
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
                      'Complete your patient profile',
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
                    title: 'Home Address',
                    controller: _addressController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Date of Birth',
                    controller: _dateOfBirthController,
                    readOnly: true,
                    onTap: _pickDateOfBirth,
                    suffixIcon: const Icon(Icons.calendar_today_outlined),
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Gender',
                    controller: _genderController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'State',
                    controller: _stateController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'LGA',
                    controller: _lgaController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Blood Group',
                    controller: _bloodGroupController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Genotype',
                    controller: _genotypeController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Height (m)',
                    controller: _heightController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Weight (kg)',
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Allergies',
                    controller: _allergiesController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Chronic Conditions',
                    controller: _chronicConditionsController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Current Medications',
                    controller: _medicationsController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Emergency Contact Name',
                    controller: _emergencyContactNameController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Emergency Contact Phone',
                    controller: _emergencyContactPhoneController,
                    keyboardType: TextInputType.phone,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Emergency Contact Relationship',
                    controller: _emergencyContactRelationshipController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Next of Kin Name',
                    controller: _nextOfKinNameController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Next of Kin Phone',
                    controller: _nextOfKinPhoneController,
                    keyboardType: TextInputType.phone,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'Next of Kin Relationship',
                    controller: _nextOfKinRelationshipController,
                    bottomPadding: 16,
                  ),
                  InputText(
                    title: 'BMI',
                    controller: _bmiController,
                    readOnly: true,
                    enabled: false,
                    bottomPadding: 0,
                  ),
                  MedBottomButton(
                    text: 'Save',
                    isLoading: state is UpdatePatientLoading,
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
    );
  }
}
