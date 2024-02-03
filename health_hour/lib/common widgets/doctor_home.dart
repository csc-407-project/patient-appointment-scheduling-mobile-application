import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/onboarding/model/appointment_model.dart';
import 'package:intl/intl.dart';
import '../features/auhtenticate/signup/signup_page.dart';

class DoctortHomePage extends StatelessWidget {
  const DoctortHomePage({
    super.key,
    required this.data,
    required this.upcomingSchedule,
  });

  final Map<String, dynamic> data;
  final List upcomingSchedule;

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
                leading: CircleAvatar(
                  radius: 30.r,
                  child: Image.asset(ProjectImages.profilePicture),
                ),
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
                    patientName: appointment.patientName,
                    date: appointment.date,
                    time: appointment.time,
                    id: snapshot.id,
                  ),
                ),);
          },
          emptyBuilder: (context) => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.art_track_sharp, size: 150, color: ProjectColors.primaryColor,),
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
    required this.patientName,
    required this.date,
    required this.time, required this.id,
  });
  final String patientName, date, time, id;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date);
  String  formattedDate =
                              DateFormat('EEE, dd MMM').format(dateTime);
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
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                SizedBox(
                  width: 0.05.sw,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patientName),
                    Text('$formattedDate | $time AM'),
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
                SizedBox(
                  width: 0.25.sw,
                  child: AppButton(
                      //background: #FD6A6A;
                      minHeight: 40,
                      backgroundColor: const Color(0xFF36A692),
                      onPressed: () async =>await  updateAppointment(appointmentId: id, status: {'status': 'approved'}, ),
                      child: Text(
                        'Approve',
                        style: ProjectConstants.regularWhiteSubTitleText
                            .copyWith(fontSize: 10.sp),
                      )),
                ),
                SizedBox(
                  width: 0.25.sw,
                  child: AppButton(
                      minHeight: 40,
                      backgroundColor: const Color(0xFFFD6A6A),
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: ProjectConstants.regularWhiteSubTitleText,
                      )),
                ),
                SizedBox(
                  width: 0.25.sw,
                  child: AppButton(
                      minHeight: 40,
                      backgroundColor: const Color(0xFF0E82FD),
                      onPressed: () {},
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
