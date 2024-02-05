import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/common%20widgets/doctors_listtile.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/onboarding/model/appointment_model.dart';
import 'package:health_hour/features/onboarding/model/notification_model.dart';
import 'package:health_hour/features/scheduling/reschedule_appointment.dart';
import 'package:health_hour/services/notification_service.dart';
import 'package:intl/intl.dart';
import '../features/auhtenticate/signup/signup_page.dart';

class DoctortHomePage extends StatelessWidget {
  const DoctortHomePage({
    super.key,
    required this.data,
   
  });

  final Map<String, dynamic> data;
  

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 0.05.sh,
      ),
      Row(
        children: [
          SizedBox(
            width: 0.75.sw,
            child: ListTile(
                leading: const AppAvatar(image: "assets/images/doctorImage.jpeg",),
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  'Dr. ${data['fullName']}',
                  style: ProjectConstants.headingNameTextStyle,
                ),
                subtitle: Text(data['specialization'])),
          ),
          // CircleAvatar(
          //   radius: 30.r,
          //   child: Image.asset(ProjectImages.profilePicture),
          // )
        ],
      ),
      SizedBox(
        height: 0.023.sh,
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Your Appointments",
          style: ProjectConstants.regularBold
              .copyWith(color: const Color(0xFF1E1F2E)),
        ),
      ),
      Expanded(
        child: FirestoreListView<Appointment>(
          showFetchingIndicator: true,
          query: appointmemntRef.where('doctorId',
              isEqualTo: firebase.currentUser?.uid),
          itemBuilder: (context, snapshot) {
            Appointment appointment = snapshot.data();
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                height: 0.23.sh,
                child: DoctorUpcScheduleCard(
                  appointment: appointment,
                  appointmentId: snapshot.id,
                ),
              ),
            );
          },
          emptyBuilder: (context) => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.art_track_sharp,
                size: 150,
                color: ProjectColors.primaryColor,
              ),
              Text("You don't have any apppointments yet"),
            ],
          ),
        ),
      )
    ]);
  }
}

class DoctorUpcScheduleCard extends StatelessWidget {
  const DoctorUpcScheduleCard({
    super.key,
    required this.appointment,
    required this.appointmentId,
  });
  final Appointment appointment;

  final String appointmentId;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(appointment.date);
    String formattedDate = DateFormat('EEE, dd MMM').format(dateTime);
    final now = DateTime.now();

// Extract hour, minute, and AM/PM indicator
    final hour = now.hour % 12; // Use modulo to get hour in 12-hour format
    final minute = now.minute;
    final period = now.hour >= 12 ? "pm" : "am";

// Format the time string
    final formattedTime =
        "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";

// Output: e.g., 02:20 pm

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: 0.085.sh,
                  width: 0.175.sw,
                  decoration: BoxDecoration(
                      color: ProjectColors.alternateTextColor,
                      borderRadius: BorderRadius.circular(12.r), image: const DecorationImage(
                        image:
                         AssetImage("assets/images/studentImage.png"),
                        fit: BoxFit.fill,
                      ),),
                ),
                SizedBox(
                  width: 0.05.sw,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appointment.patientName),
                    Text('$formattedDate | ${appointment.time} AM'),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                appointment.status == 'approved'
                    ? const SizedBox.shrink()
                    : SizedBox(
                        width:
                            appointment.status == 'approved' ? 0.3.sw : 0.25.sw,
                        child: AppButton(
                            //background: #FD6A6A;
                            minHeight: 40,
                            backgroundColor: const Color(0xFF36A692),
                            onPressed: () async {
                              await updateAppointment(
                                appointmentId: appointmentId,
                                status: {'status': 'approved'},
                              );
                              await notificationRef.add(CustomNotification(
                                  content:
                                      'Dr. ${appointment.doctorName} accepted your booking request for $formattedDate .',
                                  time: formattedTime,
                                  patientName: appointment.patientName,
                                  patientId: appointment.patientId,
                                  doctorName: appointment.doctorName,
                                  doctorId: appointment.doctorId));
                            },
                            child: Text(
                              'Approve',
                              style: ProjectConstants.regularWhiteSubTitleText
                                  .copyWith(fontSize: 10.sp),
                            )),
                      ),
                SizedBox(
                  width: 0.3.sw,
                  child: AppButton(
                      minHeight: 40,
                      backgroundColor: const Color(0xFFFD6A6A),
                      onPressed: () async{
                      await  appointmemntRef
                            .doc(appointmentId)
                            .delete()
                            .then((value) => print("Appointment Deleted"))
                            .catchError((error) =>
                                print("Failed to delete user: $error")).then((value) => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor:
                                          ProjectColors.primaryColor,
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
                                        onPressed: ()=> Navigator.pop(context),
                                        child: const Text('Ok'))
                                  ],
                                ),
                              ),
                            ),);
                      },
                      child: Text(
                        'Cancel',
                        style: ProjectConstants.regularWhiteSubTitleText,
                      )),
                ),
                SizedBox(
                  width: appointment.status == 'approved' ? 0.4.sw : 0.25.sw,
                  child: AppButton(
                      minHeight: 40,
                      backgroundColor: const Color(0xFF0E82FD),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => RescheduleAppointment(
                                  appointment: appointment,
                                  appointmentId: appointmentId))),
                      child: Text(
                        'Reschedule',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ProjectConstants.regularWhiteSubTitleText
                            .copyWith(fontSize: 10.sp),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
