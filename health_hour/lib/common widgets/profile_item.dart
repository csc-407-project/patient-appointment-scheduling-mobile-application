
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key, required this.value, required this.title, required this.icon,
  });
final String value, title;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        radius: 30.r,
        child: Icon(icon,
        size: 35.dg,
        color: ProjectColors.primaryColor,),),
      Text(value),
      Text(title)
    ],);
  }
}
