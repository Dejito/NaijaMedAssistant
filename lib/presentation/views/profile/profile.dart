import 'package:flutter/material.dart';

import '../widgets/titleText.dart';

class Profile extends StatelessWidget {

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: titleText("Profile"),
      ),
    );
  }
}
