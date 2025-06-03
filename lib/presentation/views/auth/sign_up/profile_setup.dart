import 'package:flutter/material.dart';

import '../../widgets/titleText.dart';

class ProfileSetup extends StatelessWidget {
  const ProfileSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // elevation: 1,
        title: titleText('Profile Set-up', fontSize: 16),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: Colors.grey,
            height: 2,
          ),
        ),

      ),
    );
  }
}
