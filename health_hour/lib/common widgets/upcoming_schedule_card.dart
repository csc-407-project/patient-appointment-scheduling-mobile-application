
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/constants/constants.dart';

class UpcomingScheduleCard extends StatelessWidget {
  const UpcomingScheduleCard({
    super.key, required this.name, required this.specialization, required this.date, required this.time,
  });
final String name, specialization, date, time;
  @override
  Widget build(BuildContext context) {
    return Container(
                height: 0.23.sh,
                width: 0.8.sw,
                decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.r), color: ProjectColors.primaryColor),
                child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
       ListTile(
        leading: const CircleAvatar(),
        title: Text(name, style: const TextStyle(color: Colors.white),),
        subtitle: Text(specialization, style: const TextStyle(color: Colors.white),),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 0.5.sw,
            child:  ListTile(
              title: Text(date,style: const TextStyle(color: Colors.white),),
              subtitle: Text(time,style: const TextStyle(color: Colors.white),),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Image.asset(ProjectImages.contact))
        ],
      )
    ],
                ),
              );
  }
}
