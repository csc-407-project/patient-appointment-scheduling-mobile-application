import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/app_button.dart';
import 'package:health_hour/common%20widgets/profile_item.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/scheduling/confirm_appointment.dart';

class BookDoctor extends ConsumerStatefulWidget {
  const BookDoctor({super.key, required this.doctor, required this.user});
// final String name;
// final String specialization;
  final Map<String, dynamic> doctor;
  final Map<String, dynamic> user;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScheduleAppointmentPageState();
}

class _ScheduleAppointmentPageState extends ConsumerState<BookDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 0.7.sw,
                  height: 0.35.sh,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image:
                          AssetImage("assets/images/doctorImage.jpeg"),
                      fit: BoxFit.fill,
                    ),
                    color: ProjectColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(42.r),
                        topRight: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r),
                        bottomRight: Radius.circular(42.r),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 0.03.sh,
              // ),
              Row(
                children: [
                  SizedBox(
                    width: 0.9.sw,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        'Dr. ${widget.doctor['fullName']}',
                        style: ProjectConstants.regularColoredTitleText,
                      ),
                      subtitle: Text(
                        widget.doctor['specialization'],
                        style: ProjectConstants.regularColoredSubTitleText
                            .copyWith(fontSize: 9.sp),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_outlined,
                            color: Colors.amber.shade300,
                          ),
                          const Text(
                            '4.9 (96 reviews)',
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              SizedBox(
                height: 0.12.sh,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileItem(
                        value: '116+', title: 'Patients', icon: Icons.person),
                    ProfileItem(
                        value: '4.9', title: 'Rating', icon: Icons.star),
                    ProfileItem(
                        value: '3+',
                        title: 'Years',
                        icon: Icons.calendar_month),
                    ProfileItem(
                        value: '90+',
                        title: 'Reviews',
                        icon: Icons.chat_outlined)
                  ],
                ),
              ),
              SizedBox(
                height: 0.03.sh,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'About',
                    style: ProjectConstants.regularColoredTitleText
                        .copyWith(fontWeight: FontWeight.w500),
                  )),
              Text(
                'Dr. ${widget.doctor['fullName']} is one of the top ${widget.doctor['specialization']} specialist in the country.They have achived several awards for their wonderful contribution.',
                style: ProjectConstants.regularColoredSubTitleText
                    .copyWith(fontSize: 10.sp),
              ),
              SizedBox(
                height: 0.045.sh,
              ),
              AppButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConfirmAppointment(
                            doctor: widget.doctor,
                            user: widget.user,
                          ))),
                  child: const Text('Book Appointment'))
            ]),
      ),
    );
  }
}
