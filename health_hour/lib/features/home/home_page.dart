import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/common%20widgets/upcoming_schedule_card.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/scheduling/book_doctor.dart';

import '../../common widgets/doctors_listtile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    List doctors = List.generate(
        10,
        (index) => DoctorsListTile(
              name: 'Dr Ojo',
              specialization: 'Dentist',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BookDoctor(),
              )),
            ));
    List upcomingSchedule = List.generate(
        4,
        (index) => const UpcomingScheduleCard(
            name: 'Dr. Lawal',
            specialization: 'Dentist',
            date: 'Friday, 5 Nov 2024',
            time: '09:00am - 11:00am'));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          SizedBox(
            height: 0.05.sh,
          ),
          Row(
            children: [
              SizedBox(
                width: 0.75.sw,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title:  Text('Adelanaire Ewaoluwa', style: ProjectConstants.headingNameTextStyle,),
                  subtitle: SizedBox(
                    height: 40.h,
                    child: Row(
                      children: [
                        Container(
                          height: 5.dg,
                          width: 5.dg,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          width: 0.01.sw,
                        ),
                        const Text('Cupertino - Male, 25')
                      ],
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 30.r,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text('Upcoming Schedule', style: ProjectConstants.regularBold,),
              TextButton(onPressed: () {}, child:  Text('View all', style: ProjectConstants.regularBold.copyWith(fontSize: 10.sp)))
            ],
          ),
          SizedBox(
            height: 0.23.sh,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingSchedule.length,
              itemBuilder: (context, index) => upcomingSchedule[index],
              separatorBuilder: (context, index) => SizedBox(
                width: 0.05.sw,
              ),
            ),
          ),
          SizedBox(
            height: 0.023.sh,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text("Let’s find the doctor",style: ProjectConstants.regularBold.copyWith(color: const Color(0xFF1E1F2E)),),
              IconButton(
                  onPressed: () {},
                  icon: Transform.rotate(
                      angle: 20.4, child: const Icon(Icons.tune))),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: doctors.length,
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                return doctors[index];
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 16.h,
              ),
            ),
          )
          // ListView()
          // const Row(),
        ]),
      ),
    );
  }
}
