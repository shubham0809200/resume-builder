import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildTextField({
  String? title,
  String? hintText,
  bool? obscureText,
  required TextEditingController controller,
  required Function(String) onChanged,
  TextInputType? textInputType,
}) {
  return SizedBox(
    height: 40,
    child: TextField(
      obscureText: obscureText ?? false,
      controller: controller,
      onChanged: onChanged,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(title ?? '',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF000000),
            )),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

buildTextFieldWithoutLabel({
  required TextEditingController controller,
  required Function(String) onChanged,
  Function()? onTap,
  TextInputType? textInputType,
  String? hintText,
  String? labelText,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: labelText ?? '',
      hintText: hintText ?? '',
    ),
    keyboardType: textInputType ?? TextInputType.text,
    onChanged: onChanged,
    onTap: onTap ?? () {},
  );
}
