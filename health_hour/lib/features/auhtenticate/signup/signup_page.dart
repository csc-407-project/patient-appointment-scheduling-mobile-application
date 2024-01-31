import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/common%20widgets/app_textfield.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/auhtenticate/signin/signin_page.dart';
import 'package:health_hour/features/home/home_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage(this.userType, {super.key});
  final String userType;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final firebase = FirebaseAuth.instance;
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
              height: 0.1.sh,
            ),
            Text(
              'Welcome!',
              style: ProjectConstants.heading
                  .copyWith(color: ProjectColors.primaryColor),
            ),
            const Text("Let’s get started creating a patient account."),
            SizedBox(
              height: 0.03.sh,
            ),
            AppTextField(
              controller: nameController,
              label: 'Full Name',
              prefixIcon: Icons.person_rounded,
            ),
            SizedBox(
              height: 0.026.sh,
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
              height: 0.026.sh,
            ),
            AppButton(
              onPressed: () async {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  final result = await firebase.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                  User? user = result.user;
                  await user!.updateDisplayName(nameController.text);
                  await user.reload();

                  DocumentReference users =
                      FirebaseFirestore.instance.doc('users/${user.uid}');
                  await users.set({
                    'fullName': nameController.text,
                    'id': user.uid,
                    'email': user.email,
                    'userType': widget.userType
                  }).then((value) => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage(firebase.currentUser))));
                }
              },
              child: const Text(
                'Sign Up',
              ),
            ),
            SizedBox(
              height: 0.3.sh,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignInPage()));
                    },
                    child: Text(
                      'Sign In',
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


// User? user = value.user;
//                           user!.updateDisplayName(nameController.text);
//                          user.reload();
                      
//                         DocumentReference users = FirebaseFirestore.instance
//                             .doc('users/${user.uid}');
//                          users.set({
//                           'fullName': nameController.text,
//                           'id': user.uid,
//                           'email': user.email,
//                           'userType': widget.userType
//                         });