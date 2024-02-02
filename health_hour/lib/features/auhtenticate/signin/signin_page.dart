import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/common%20widgets/app_textfield.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/auhtenticate/get_started_page.dart';
import 'package:health_hour/features/home/bottom_navbar.dart';

 User? currentUser;
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
                emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty
                    ? await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                            
                        .then((value) {
                      //     final userq =FirebaseFirestore.instance
                      // .collection('users').where('id', isEqualTo: value.user!.uid);
                      // final userSnapshot =  userq.get();

                      // print(userq.toString());
                      currentUser = value.user;
                        return Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>  BottomNav(value.user)));
                        
                      })
                    : null;
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
