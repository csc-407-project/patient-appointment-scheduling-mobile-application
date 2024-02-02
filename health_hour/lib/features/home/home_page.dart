import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/doctor_home.dart';
import 'package:health_hour/common%20widgets/student_home.dart';

import 'package:health_hour/common%20widgets/upcoming_schedule_card.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/scheduling/book_doctor.dart';

import '../../common widgets/doctors_listtile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage(this.user, {super.key});
  final User? user;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // final usersQuery = FirebaseFirestore.instance.collection('users').get();

// }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    List upcomingSchedule = List.generate(
        4,
        (index) => const UpcomingScheduleCard(
            name: 'Dr. Lawal',
            specialization: 'Dentist',
            date: 'Friday, 5 Nov 2024',
            time: '09:00am - 11:00am'));
    return Scaffold(
      body: FutureBuilder(
        future: users.doc(widget.user!.uid).get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: data['userType'] == 'Student'
                  ? StudentHomePage(
                      data: data, upcomingSchedule: upcomingSchedule)
                  : DoctortHomePage(
                      data: data, upcomingSchedule: upcomingSchedule),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
