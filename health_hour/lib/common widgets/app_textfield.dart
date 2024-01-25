
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
  });
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(label!),
          prefixIcon: Icon(prefixIcon!),
          suffixIcon: Icon(suffixIcon),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.r)))),
    );
  }
}
