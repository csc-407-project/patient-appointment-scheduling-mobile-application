import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/common%20widgets/doctors_listtile.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/scheduling/book_doctor.dart';

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
    print(data.toString());
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
          ) ,
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  'Dr.${data['fullName']}',
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
        child: FirestoreListView<Map<String, dynamic>>(
          showFetchingIndicator: true,
          query: FirebaseFirestore.instance.collection('users').where(
              'userType',
              isEqualTo: 'Doctor') // Access users collection
          ,
          // usersQuery,
          itemBuilder: (context, snapshot) {
            Map<String, dynamic> data = snapshot.data();
        
            return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  height: 0.23.sh,
                  child: Card(
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
                                    borderRadius:
                                        BorderRadius.circular(12.r)),
                              ),
                              SizedBox(
                                width: 0.05.sw,
                              ),
                              const Column(
                                children: [
                                  Text('Adelanaire Ewaoluwa'),
                                  Text('Wed, 17 May | 8:30 AM'),
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
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 0.25.sw,
                                child: AppButton(
                                    //background: #FD6A6A;
                                    minHeight: 40,
                                    backgroundColor:
                                        const Color(0xFF36A692),
                                    onPressed: () {},
                                    child: Text(
                                      'Approve',
                                      style: ProjectConstants
                                          .regularWhiteSubTitleText
                                          .copyWith(fontSize: 10.sp),
                                    )),
                              ),
                              SizedBox(
                                width: 0.25.sw,
                                child: AppButton(
                                    minHeight: 40,
                                    backgroundColor:
                                        const Color(0xFFFD6A6A),
                                    onPressed: () {},
                                    child: Text(
                                      'Cancel',
                                      style: ProjectConstants
                                          .regularWhiteSubTitleText,
                                    )),
                              ),
                              SizedBox(
                                width: 0.25.sw,
                                child: AppButton(
                                    minHeight: 40,
                                    backgroundColor:
                                        const Color(0xFF0E82FD),
                                    onPressed: () {},
                                    child: Text(
                                      'Reschedule',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: ProjectConstants
                                          .regularWhiteSubTitleText
                                          .copyWith(fontSize: 10.sp),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
               
                );
          },
        ),
      )
    ]);
  }
}
