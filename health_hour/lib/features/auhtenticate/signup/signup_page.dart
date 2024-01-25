import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/common%20widgets/app_textfield.dart';
import 'package:health_hour/features/auhtenticate/signin/signin_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
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
            const Text('Welcome!'),
            const Text("Let’s get started creating a patient account."),
            SizedBox(
              height: 0.026.sh,
            ),
            const AppTextField(
              label: 'Full Name',
              prefixIcon: Icons.person_rounded,
            ),
            SizedBox(
              height: 0.026.sh,
            ),
            const AppTextField(
              label: 'Email',
              prefixIcon: Icons.mail_outlined,
            ),
            SizedBox(
              height: 0.026.sh,
            ),
            const AppTextField(
              label: 'Password',
              prefixIcon: Icons.lock_outline,
              suffixIcon: Icons.remove_red_eye,
            ),
            SizedBox(
              height: 0.026.sh,
            ),
            AppButton(
              onPressed: () {},
              child: const Text('Sign Up'),
            ),
            SizedBox(
              height: 0.3.sh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignInPage()));
                }, child: const Text('Sign In')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
