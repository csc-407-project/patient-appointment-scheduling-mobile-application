import 'package:cloud_firestore/cloud_firestore.dart';

class CustomNotification {
  CustomNotification({
    required this.content,
    required this.patientName,
    required this.patientId,
    required this.doctorName,
    required this.doctorId,
    required this.time,
  });

  CustomNotification.fromJson(Map<String, Object?> json)
      : this(
          patientName: json['patientName']! as String,
          patientId: json['patientId']! as String,
          doctorId: json['doctorId']! as String,
          doctorName: json['doctorName']! as String,
          content: json['content']! as String,
          time: json['time']! as String,
        );

  final String patientName, patientId, doctorName, doctorId, content, time;

  Map<String, Object?> toJson() {
    return {
      'patientName': patientName,
      'patientId': patientId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'content': content,
      'time': time,
    };
  }
}

final notificationRef = FirebaseFirestore.instance
    .collection('notifications')
    .withConverter<CustomNotification>(
      fromFirestore: (snapshot, _) => CustomNotification.fromJson(snapshot.data()!),
      toFirestore: (notification, _) => notification.toJson(),
    );

    final userRef = FirebaseFirestore.instance
    .collection('users')
    .withConverter<AppUser>(
      fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
      toFirestore: (notification, _) => notification.toJson(),
    );
class AppUser {
  final String id,email, userType, specialization, fullName;

  AppUser({required this.id, required this.email, required this.userType, required this.specialization, required this.fullName});

AppUser.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          email: json['email']! as String,
          userType: json['userType']! as String,
          specialization: json['specialization']! as String,
          fullName: json['fullName']! as String,
         
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'userType': userType,
      'specialization': specialization,
      'fullName': fullName,
     
    };
  }
}