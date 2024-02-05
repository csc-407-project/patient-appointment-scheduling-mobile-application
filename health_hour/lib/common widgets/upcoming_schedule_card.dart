import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/onboarding/model/appointment_model.dart';
import 'package:health_hour/features/onboarding/model/notification_model.dart';
import 'package:health_hour/features/scheduling/reschedule_appointment.dart';
import 'package:intl/intl.dart';

class UpcomingScheduleCard extends StatelessWidget {
  const UpcomingScheduleCard({
    super.key,
    required this.name,
    required this.specialization,
    required this.date,
    required this.time,
    required this.appointment,
    required this.appointmentId,
  });
  final String name, specialization, date, time, appointmentId;
  final Appointment appointment;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('EEEEEE, dd MMM yyyy').format(dateTime);
       
    
    final now = DateTime.now();

// Extract hour, minute, and AM/PM indicator
    final hour = now.hour % 12; // Use modulo to get hour in 12-hour format
    final minute = now.minute;
    final period = now.hour >= 12 ? "pm" : "am";

// Format the time string
    final formattedTime =
        "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
    return InkWell(
      onLongPress: () async {
        await appointmemntRef
            .doc(appointmentId)
            .delete()
            .then((value) => print("Appointment Deleted"))
            .catchError((error) => print("Failed to delete user: $error"));
            await notificationRef.add(CustomNotification(
                                  content:
                                      'Your appointment with Dr. ${appointment.doctorName}  for $formattedDate has been cancelled',
                                  time: formattedTime,
                                  patientName: appointment.patientName,
                                  patientId: appointment.patientId,
                                  doctorName: appointment.doctorName,
                                  doctorId: appointment.doctorId)) .then(
              (value) => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundColor: ProjectColors.primaryColor,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 0.025.sh,
                      ),
                      const Text(
                        'Your appointment has been cancelled successfully',
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Ok'))
                    ],
                  ),
                ),
              ),
            );
      },
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RescheduleAppointment(
              appointment: appointment, appointmentId: appointmentId))),
      child: Container(
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
                        style: ProjectConstants.regularWhiteSubTitleText
                            .copyWith(
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
      ),
    );
  }
}
