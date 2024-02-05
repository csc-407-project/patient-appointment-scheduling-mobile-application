import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/common%20widgets/app_textfield.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/auhtenticate/get_started_page.dart';
import 'package:health_hour/features/home/bottom_navbar.dart';
import 'package:health_hour/features/onboarding/model/appointment_model.dart';
import 'package:health_hour/features/onboarding/model/user_model.dart';

User? currentUser;
AppUser? currentUserData;
getUserData(String? id) async {
  // final _userData = await users.doc(id).get();
  // print(_userData.data().toString());
//  Map<String, dynamic> userData = jsonDecode('${_userData.data().toString()}');

  userRef.where('id', isEqualTo: id).get().then((snapshot) {
    currentUserData = snapshot.docs[0].data();
  });
  return currentUserData;
}

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool validateEmail(String email) {
    // Convert email to lowercase for case-insensitive comparison
    final lowerCaseEmail = email.toLowerCase();

    // Use Dart's RegExp class for pattern matching
    final emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    // Return true if the email matches the regular expression
    return emailRegex.hasMatch(lowerCaseEmail);
  }
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
                suffixIcon: IconButton(onPressed: (){}, icon: obscureText ? Icon(Icons.visibility):Icon(Icons.visibility_off) ),
              obscureText: true,
            ),
            SizedBox(
              height: 0.06.sh,
            ),
            AppButton(
              onPressed: () async {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  if (validateEmail(emailController.text)) {
                    try {
                      final user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                    currentUser = user.user;
                    await userRef
                        .where('id', isEqualTo: currentUser!.uid)
                        .get()
                        .then((snapshot) {
                      currentUserData = snapshot.docs[0].data();
                      return Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => BottomNav(
                                    user: currentUser,
                                    userData: snapshot.docs[0].data(),
                                  )));
                    });
                    }on FirebaseAuthException catch(e)  {
                      Fluttertoast.showToast(
                        msg: getMessageFromErrorCode(e.code),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    }
                    
                  } else {
                    Fluttertoast.showToast(
                        msg: "Invalid email format",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                } else {}
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
                    child: Text(
                      'Sign Up',
                      style: ProjectConstants.coloredTextButton,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


String getMessageFromErrorCode(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
       
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
       
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
       
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
   
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";

      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
    
      default:
        return "Auth failed. Please try again.";
   
    }
  }