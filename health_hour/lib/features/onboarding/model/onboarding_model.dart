
import 'package:health_hour/constants/constants.dart';

class OnBoardItem {
  final String header, description, image;

  OnBoardItem({
    required this.header,
    required this.description,
    required this.image,
  });
}

List<OnBoardItem> onBoardingPages = [
  OnBoardItem(
      header: 'Your instant health appointment solution on the go!',
      description:
          'Instantly book and manage your appointments for a seamless healthcare experience."',
      image: ProjectImages.onboardingImage1),
  OnBoardItem(
      header: 'One app for  your quick health fix',
      description:
          'Your health appointment solution. Schedule, manage, and prioritize your well-being on-the-go.',
      image:ProjectImages.onboardingImage2),
  OnBoardItem(
      header: 'Simplifying your well-being scheduling.',
      description:
          'Simplifies the process of scheduling appointments for your well-being, ensuring efficiency and ease.',
      image:ProjectImages.onboardingImage3),
];