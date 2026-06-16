import 'package:flutter/material.dart';

import '../../views/widgets/elevated_bottom_button.dart';
import '../../views/widgets/titleText.dart';
import './auth_widgets.dart';

enum UserRole {
  patient('PATIENT'),
  doctor('DOCTOR');

  final String label;
  const UserRole(this.label);
}

class UserRoleSelectionScreen extends StatefulWidget {
  const UserRoleSelectionScreen({super.key});

  @override
  State<UserRoleSelectionScreen> createState() => _UserRoleSelectionScreenState();
}

class _UserRoleSelectionScreenState extends State<UserRoleSelectionScreen> {
  // Track the selected role; null means nothing selected yet.
  UserRole? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleText("NaijaMed Assistant",
                  fontSize: 26,
                  color: const Color(0xFF002553),
                  fontWeight: FontWeight.w500,
                  topPadding: 12,
                  bottomPadding: 24),

              const SizedBox(height: 24),

              logoImage(height: 160),

              const SizedBox(height: 32),

              titleText(
                "Medical Care, On Demand, Always",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                bottomPadding: 40,
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "I am a :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 28),
                  _buildRoleOption(UserRole.patient),
                  const SizedBox(width: 32),
                  _buildRoleOption(UserRole.doctor),
                ],
              ),

              const SizedBox(height: 40),

              MedBottomButton(
                text: "Get Started",
                onPressed: selectedRole == null
                    ? null
                    : () {
                        // You can pass 'selectedRole' down to your routing or auth state logic here!
                        // print(selectedRole);
                        // context.go(AppRoutes.appPage);
                      },
                topMargin: 30,
                bottomMargin: 12,
              ),
              const SizedBox(height: 16),
              newHereButton(
                label: "Don't have an account ",
                onClickedSignup: () {
                  // context.go(AppRoutes.signup);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleOption(UserRole role) {
    final bool isSelected = selectedRole == role;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: isSelected
                ? const Icon(Icons.check, size: 14, color: Colors.black)
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            role.label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
