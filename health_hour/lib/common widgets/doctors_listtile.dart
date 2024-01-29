
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsListTile extends StatelessWidget {
  const DoctorsListTile({
    super.key, required this.name, required this.specialization, required this.onTap, 
  });
final String name, specialization;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      title:  Text(name),
      subtitle: Text(specialization),
      leading: const CircleAvatar(),
      trailing: IconButton(
          onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined),),
      onTap: onTap,
    );
  }
}
