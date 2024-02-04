import 'package:cloud_firestore/cloud_firestore.dart';


CollectionReference users = FirebaseFirestore.instance.collection('users');
class Appointment {
  Appointment(  {required this.status, required this.date, required this.specialization, required this.patientName, required this.patientId,required this.doctorName,required this.doctorId,required this.time,});

  Appointment.fromJson(Map<String, Object?> json)
    : this(
        time: json['time']! as String,
        patientName: json['patientName']! as String,
        patientId: json['patientId']! as String,
        doctorId: json['doctorId']! as String,
        doctorName: json['doctorName']! as String,
        date: json['date']! as String,
        specialization: json['specialization']! as String,
         status: json['status']! as String,
      );

  final String patientName, patientId, doctorName, doctorId, time, date, specialization, status;
 

  Map<String, Object?> toJson() {
    return {
      'time': time,
      'patientName': patientName,
      'patientId': patientId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'date': date,
      'specialization': specialization,
      'status': status,
    };
  }
}

final appointmemntRef = FirebaseFirestore.instance.collection('appointments').withConverter<Appointment>(
      fromFirestore: (snapshot, _) => Appointment.fromJson(snapshot.data()!),
      toFirestore: (appointment, _) => appointment.toJson(),
    );

    CollectionReference appointments = FirebaseFirestore.instance.collection('appointments');

Future<void> updateAppointment({ required String appointmentId, required Map<String, dynamic> status}) {
  return appointments
    .doc(appointmentId)
    .update(status)
    .then((value) => print("Appointment Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}