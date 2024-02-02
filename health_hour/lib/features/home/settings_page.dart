import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/features/auhtenticate/signin/signin_page.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: AppButton(
                    onPressed: () async {
            await FirebaseAuth.instance.signOut().then((value) =>
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SignInPage())));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 30,),
                        Text('Log out'),
                      ],
                    ),
                  ),
          )),
    );
  }
}
