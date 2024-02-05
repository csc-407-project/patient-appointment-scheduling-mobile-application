import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/constants/constants.dart';

class DoctorsListTile extends StatelessWidget {
  const DoctorsListTile({
    super.key,
    required this.name,
    required this.specialization,
    required this.onTap,
  });
  final String name, specialization;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      title: Text(
        'Dr. $name',
        style: ProjectConstants.regularWhiteTitleText
            .copyWith(color: ProjectColors.textColor),
      ),
      subtitle: Text(
        specialization,
        style: ProjectConstants.regularWhiteSubTitleText
            .copyWith(color: ProjectColors.alternateTextColor, fontSize: 10.sp),
      ),
      leading:AppAvatar(image: "assets/images/doctorImage.jpeg",),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_horiz_outlined),
      ),
      onTap: onTap,
    );
  }
}

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key, required this.image,
  });
final String image;
  @override
  Widget build(BuildContext context) {
    return Container( 
      height: 50,
      width: 50,
      decoration: ShapeDecoration(
                  image:  DecorationImage(
                    image:
                        AssetImage(image),
                    fit: BoxFit.fill,
                  ),
                  color: ProjectColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                     Radius.circular(30.r)
                    ),
                  ),
                ),);
  }
}
