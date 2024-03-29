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

    