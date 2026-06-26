
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void showEaseLoadingIndicator(){
  EasyLoading.show(
      indicator: const CircularProgressIndicator(
        color: Colors.white,
      ),
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false
  );
}

void dismissEaseLoadingIndicator(){
  EasyLoading.dismiss();
}

