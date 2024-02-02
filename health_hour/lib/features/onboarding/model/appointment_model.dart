import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  Appointment(  {required this.date, required this.specialization, required this.patientName, required this.patientId,required this.doctorName,required this.doctorId,required this.time,});

  Appointment.fromJson(Map<String, Object?> json)
    : this(
        time: json['time']! as String,
        patientName: json['patientName']! as String,
        patientId: json['patientId']! as String,
        doctorId: json['doctorId']! as String,
        doctorName: json['doctorName']! as String,
        date: json['date']! as String,
        specialization: json['specialization']! as String,
      );

  final String patientName, patientId, doctorName, doctorId, time, date, specialization;
 

  Map<String, Object?> toJson() {
    return {
      'time': time,
      'patientName': patientName,
      'patientId': patientId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'date': date,
      'specialization': specialization,
    };
  }
}

final appointmemntRef = FirebaseFirestore.instance.collection('appointments').withConverter<Appointment>(
      fromFirestore: (snapshot, _) => Appointment.fromJson(snapshot.data()!),
      toFirestore: (appointment, _) => appointment.toJson(),
    );