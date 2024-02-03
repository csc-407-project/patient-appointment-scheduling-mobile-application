import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:intl/intl.dart';

class UpcomingScheduleCard extends StatelessWidget {
  const UpcomingScheduleCard({
    super.key,
    required this.name,
    required this.specialization,
    required this.date,
    required this.time,
  });
  final String name, specialization, date, time;
  @override
  Widget build(BuildContext context) {
     DateTime dateTime = DateTime.parse(date);
  String  formattedDate =  DateFormat('EEEEEE, dd MMM yyyy').format(dateTime);
    return Container(
      height: 0.225.sh,
      width: 0.8.sw,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [ProjectColors.primaryColor, Color(0xFF284179)],
              begin: AlignmentDirectional(0, -3.6),
              end: Alignment.bottomRight,
              stops: [0.6, 0.95]),
          borderRadius: BorderRadius.circular(15.r),
          color: ProjectColors.primaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            leading: const CircleAvatar(),
            title: Text(name, style: ProjectConstants.regularWhiteTitleText),
            subtitle: Text(specialization,
                style: ProjectConstants.regularWhiteSubTitleText),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 0.5.sw,
                child: ListTile(
                  title: Text(formattedDate,
                      style: ProjectConstants.regularWhiteSubTitleText.copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.w500)),
                  subtitle: Text(time,
                      style: ProjectConstants.regularWhiteSubTitleText),
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: Image.asset(ProjectImages.contact))
            ],
          )
        ],
      ),
    );
  }
}
