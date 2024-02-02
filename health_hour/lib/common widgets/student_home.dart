
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/doctors_listtile.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/scheduling/book_doctor.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({
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
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                data['fullName'],
                style: ProjectConstants.headingNameTextStyle,
              ),
              subtitle: SizedBox(
                height: 40.h,
                child: Row(
                  children: [
                    Container(
                      height: 5.dg,
                      width: 5.dg,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 0.01.sw,
                    ),
                    const Text('Cupertino - Male, 25')
                  ],
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 30.r,
            child: Image.asset(ProjectImages.profilePicture),
          )
        ],
      ),
     
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Upcoming Schedule',
            style: ProjectConstants.regularBold,
          ),
          TextButton(
              onPressed: () {},
              child: Text('View all',
                  style: ProjectConstants.regularBold
                      .copyWith(fontSize: 10.sp)))
        ],
      ),
      SizedBox(
        height: 0.23.sh,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: upcomingSchedule.length,
          itemBuilder: (context, index) => upcomingSchedule[index],
          separatorBuilder: (context, index) => SizedBox(
            width: 0.05.sw,
          ),
        ),
      ),
      SizedBox(
        height: 0.023.sh,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Let’s find the doctor",
            style: ProjectConstants.regularBold
                .copyWith(color: const Color(0xFF1E1F2E)),
          ),
          IconButton(
              onPressed: () {},
              icon: Transform.rotate(
                  angle: 20.4, child: const Icon(Icons.tune))),
        ],
      ),
      Expanded(
        child: SizedBox(
            height: 0.23.sh,
            child: FirestoreListView<Map<String, dynamic>>(
              showFetchingIndicator: true,
              query: FirebaseFirestore.instance
                  .collection('users').where('userType', isEqualTo: 'Doctor') // Access users collection
              ,
              // usersQuery,
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> data = snapshot.data();

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DoctorsListTile(
                    name:data['fullName'] ?? '' ,
                    specialization: data['specialization'] ?? '',
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  BookDoctor(data, ),
                    )),
                  ),
                );
              },
            )),
      
      )
    ]);
  }
}
