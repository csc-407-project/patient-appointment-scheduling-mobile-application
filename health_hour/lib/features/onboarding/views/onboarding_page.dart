import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_hour/features/auhtenticate/get_started_page.dart';
import 'package:health_hour/features/onboarding/provider/onboarding_provider.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common widgets/app_button.dart';
import '../../../constants/constants.dart';
import '../model/onboarding_model.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    int currentPage = ref.watch(pageProvider);
    return Scaffold(
      body: Padding(
        padding: ProjectConstants.generalPadding,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: onBoardingPages.length,
                // physics: ,
                onPageChanged: (value) =>
                    ref.read(pageProvider.notifier).changePage(value),
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      onBoardingPages[currentPage].image,
                      height: 0.5.sh,
                      width: 0.75.sw,
                    ),
                    // SvgPicture.asset(onBoardingPages[currentPage].image),
                    Text(
                      onBoardingPages[currentPage].header,
                      style: ProjectConstants.heading,
                      textAlign: TextAlign.center,
                    ),
                    ProjectConstants.largeSpacing,
                    Text(
                      onBoardingPages[index].description,
                      style: ProjectConstants.onboardingBody,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSmoothIndicator(
              activeIndex: currentPage,
              count: 3,
              effect: const WormEffect(
                  spacing: 20.0,
                  radius: 8.0,
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  // paintStyle: PaintingStyle.stroke,
                  // strokeWidth: 1.5,
                  // dotColor: ProjectColors.primaryGreen,
                  activeDotColor: ProjectColors.primaryColor),
              onDotClicked: (index) {
                ref.read(pageProvider.notifier).dotClicked(index);
              },
            ),
            ProjectConstants.largeSpacing,
            AppButton(
                child: SizedBox(
                  // width: 60.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  ref
                      .read(onboardingRepositoryProvider)
                      .setOnboardingComplete(true);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const GetStarted()));
                  // Navigate to sign up screen
                }),
          ],
        ),
      ),
    );
  }
}



 // TextButton(
            //   onPressed: () {
            //     ref
            //         .read(onboardingRepositoryProvider)
            //         .setOnboardingComplete(true);
            //     Navigator.of(context).pushReplacement(
            //         MaterialPageRoute(builder: (context) => const SignUp()));
            //   },
            //   child: const Text(
            //     'Skip and continue',
            //   ),
            // ),


             // if (currentPage < 2) {
                  //   ref.read(pageProvider.notifier).changePage();
                  // }
                  // if (currentPage == 2) {
                  //   ref
                  //       .read(onboardingRepositoryProvider)
                  //       .setOnboardingComplete(true);
                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //       builder: (context) => const SignUp()
                  //       ));
                  // }