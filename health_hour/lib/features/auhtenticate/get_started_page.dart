import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/auhtenticate/signup/signup_page.dart';

class GetStarted extends ConsumerStatefulWidget {
  const GetStarted({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetStartedState();
}

class _GetStartedState extends ConsumerState<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Image.asset(
              ProjectImages.getStartedImage,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Get Started as a:'),
                   SizedBox(
                    height: 0.008.sh,
                  ),
                  AppButton(
                    onPressed: () {
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignUpPage()));
                    },
                    backgroundColor: Colors.white,
                    foregroundColor: ProjectColors.primaryColor,
                    child: const Text('Doctor'),
                  ),
                   SizedBox(
                    height: 0.026.sh,
                  ),
                  AppButton(
                    onPressed: () {
                       Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignUpPage()));
                    },
                    backgroundColor: Colors.white,
                    foregroundColor: ProjectColors.primaryColor,
                    child: const Text('Student'),
                  ),
                   SizedBox(
                    height: 0.125.sh,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () {

                          }, child: const Text('Sign In')),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
