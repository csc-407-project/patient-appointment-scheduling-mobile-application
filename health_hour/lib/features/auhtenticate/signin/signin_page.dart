import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/common%20widgets/app_textfield.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/auhtenticate/get_started_page.dart';
import 'package:health_hour/features/home/bottom_navbar.dart';
import 'package:health_hour/features/onboarding/model/appointment_model.dart';

 User? currentUser;
 getUserData(String? id) async {
   final _userData = await  users.doc(id).get();
   print(_userData.data().toString());
//  Map<String, dynamic> userData = jsonDecode('${_userData.data().toString()}');
   return _userData;
  }
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 0.125.sh,
            ),
            Text('Welcome!',
                style: ProjectConstants.heading
                    .copyWith(color: ProjectColors.primaryColor)),
            const Text("Let’s get started creating a patient account."),
            SizedBox(
              height: 0.06.sh,
            ),
            AppTextField(
              controller: emailController,
              label: 'Email',
              prefixIcon: Icons.mail_outlined,
            ),
            SizedBox(
              height: 0.026.sh,
            ),
            AppTextField(
              controller: passwordController,
              label: 'Password',
              prefixIcon: Icons.lock_outline,
              suffixIcon: Icons.remove_red_eye,
            ),
            SizedBox(
              height: 0.06.sh,
            ),
            AppButton(
              onPressed: () async {
                if ( emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                  final user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                             currentUser = user.user;
                             await getUserData(currentUser!.uid).then((value) {
              
                     
                     
                        return Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>  BottomNav(user:currentUser,)));
                        
                      });
                }
               
                   
              },
              child: const Text('Sign In'),
            ),
            SizedBox(
              height: 0.3.sh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New User?'),
                TextButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const GetStarted())),
                    child:  Text('Sign Up',  style: ProjectConstants.coloredTextButton,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
