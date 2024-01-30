import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectConstants {
  //// This class is for constants like padding so we don't have too much boilerplate codes.
  ///The constants can be accessed by calling ProjectConstant.<name of constant>

  static const EdgeInsets generalPadding = EdgeInsets.all(24);
  static const SizedBox largeSpacing = SizedBox(height: 24);
  static const SizedBox regSpacing = SizedBox(height: 16);

  static TextStyle heading = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 25.sp,
  );

  static TextStyle onboardingBody = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15.sp,
  );
  static TextStyle coloredTextButton = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 15.sp,
      color: ProjectColors.primaryColor);

  static TextStyle headingNameTextStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 21.sp,
      color: ProjectColors.textColor);

  static TextStyle regularBold = GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 13.sp,
      color: ProjectColors.textColor);

  static TextStyle regularWhiteTitleText = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: Colors.white,
  );

  static TextStyle regularWhiteSubTitleText = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: Colors.white,
  );

  static TextStyle regularColoredTitleText = ProjectConstants
      .regularWhiteTitleText
      .copyWith(color: ProjectColors.textColor);
      
  static TextStyle regularColoredSubTitleText = ProjectConstants
      .regularWhiteSubTitleText
      .copyWith(color: ProjectColors.textColor);
}

class ProjectImages {
  //// This class is for images like padding so we don't have too much boilerplate codes.
  ///The constants can be accessed by calling ProjectImages.<name of constant>
  static const String onboardingImage2 = 'assets/images/Group 3924O2.png';
  static const String onboardingImage3 = 'assets/images/Group 3925O3.png';
  static const String onboardingImage1 = 'assets/images/Onboarding1.png';
  static const String getStartedImage = 'assets/images/ImageGS.jpg';
  static const String contact = 'assets/images/Picture.png';
//     static const String onboardingImage2 = 'assets/images/Group 3924.svg';
//  static const String onboardingImage3 = 'assets/images/Group 3925.svg';
//  static const String onboardingImage1 = 'assets/images/Group 3928.svg';
}

class ProjectColors {
  // Colors go in here , format for colors given next line
  // static const Color grey = Color(0xff84838B);
  // The colors can be accessed by calling ProjectColor.<name of color>

  static const Color primaryColor = Color(0xFF2F195A);
  static const Color textColor = Color(0xFF324F5E);
  static const Color alternateTextColor = Color(0xFF96A7AF);

//  static const Color primaryGreen =  Color(0xFF99E79B);
}
