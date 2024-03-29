import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_hour/features/auhtenticate/signin/signin_page.dart';
import 'package:health_hour/features/home/bottom_navbar.dart';
import 'package:health_hour/features/onboarding/model/user_model.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  final firebase = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: firebase.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user?.uid != null) {
              getUserData(user?.uid);

              return FutureBuilder<AppUser>(
                future: userRef
                    .where('id', isEqualTo: user?.uid)
                    .get()
                    .then((snapshot) {
                 return snapshot.docs[0].data();
                }),
                builder: (context, snapshot) => BottomNav(
                  user: user,
                  userData: snapshot.data!,
                ),
              );
            } else {
              return const SignInPage();
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
