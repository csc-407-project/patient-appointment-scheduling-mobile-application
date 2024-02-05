import 'package:cloud_firestore/cloud_firestore.dart';

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

final userRef = FirebaseFirestore.instance
    .collection('users')
    .withConverter<AppUser>(
      fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
      toFirestore: (notification, _) => notification.toJson(),
    );
