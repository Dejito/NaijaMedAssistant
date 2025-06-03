import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';
import '../widgets/titleText.dart';

class Dashboard extends StatelessWidget {

  static const route = '/dashboard';

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // elevation: 1,
        backgroundColor: AppColors.white,
        title: titleText('Profile Set-up', fontSize: 16),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: Colors.grey,
            height: 2,
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.black,
            )),
            child: Icon(Icons.person),
          )
        ],
      ),
    );
  }
}
