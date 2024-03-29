import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/auhtenticate/signup/signup_page.dart';
import 'package:health_hour/features/onboarding/model/notification_model.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text(
          'Notifications',
          style: ProjectConstants.regularColoredTitleText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FirestoreListView(
            emptyBuilder: (context) => const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off_outlined,
                      size: 150,
                    ),
                    Text(
                      "Your notifications will show here as soon as you get one",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
            query: notificationRef.where('patientId',
                isEqualTo: firebase.currentUser?.uid).orderBy('time', descending: true),
            itemBuilder: (context, snapshot) {
              final notification = snapshot.data();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  leading: CircleAvatar(
                    radius: 30.r,
                    child: Image.asset(ProjectImages.profilePicture),
                  ),
                  title: Text(notification.content),
                  subtitle: Text(notification.time),
                ),
              );
            }),
      ),
    );
  }
}
