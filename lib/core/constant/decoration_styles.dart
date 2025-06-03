import 'package:flutter/material.dart';

class AppDecorationStyle {
  
  static var boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 2,
        offset: Offset(0, 2),
      ),
    ],
  );
  
}
