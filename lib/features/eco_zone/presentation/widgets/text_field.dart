// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required bool obscureText,
  required BuildContext context,
  Widget? suffixIcon,
}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    margin: EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white, width: 1),
      boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5),
      ],
    ),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: InputBorder.none,
        suffixIcon: suffixIcon,
        errorStyle: TextStyle(
          color: Colors.black,  
          fontSize: 17,  
        ),
      ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    ),
  );
}
