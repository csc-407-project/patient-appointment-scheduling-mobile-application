
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.label, this.controller, this.obscureText = false
  });
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final TextEditingController? controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Text(label!),
          prefixIcon: Icon(prefixIcon!),
          suffixIcon: suffixIcon,
          
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.r)))),
    );
  }
}
