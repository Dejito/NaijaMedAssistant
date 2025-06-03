import 'package:flutter/material.dart';

Widget buildTextField(String hintText, String textType, void Function(String value)? onTextChanged) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        textType == "email"
            ? Icons.alternate_email
            : textType == "password"
            ? Icons.lock_outline
            : Icons.person_2_outlined,
        color: Colors.grey,
        size: 24,
      ),
      const SizedBox(width: 12),
      Expanded(
        child: TextFormField(
          onChanged: onTextChanged,
          keyboardType: textType == "email"
              ? TextInputType.emailAddress
              : TextInputType.text,
          autocorrect: false,
          obscureText: textType == "password",
          decoration: InputDecoration(
            hintText: hintText,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.6),
            ),
          ),
          style: const TextStyle(fontFamily: "Avenir"),
        ),
      ),
    ],
  );
}
