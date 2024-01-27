import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_hour/constants/constants.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
     List doctors = List.generate(10, (index) => const DoctorsListTile(name: 'Dr Ojo', specialization: 'Dentist'));
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
                  title: const Text('Adelanaire Ewaoluwa'),
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
              const Text('Upcoming Schedule'),
              TextButton(onPressed: () {}, child: const Text('View all'))
            ],
          ),
          const Center(
              child:UpcomingScheduleCard(name: 'Dr. Lawal', specialization: 'Dentist', date: 'Friday, 5 Nov 2024', time: '09:00am - 11:00am')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Let’s find the doctor"),
              IconButton(
                  onPressed: () {},
                  icon: Transform.rotate(
                      angle: 20.4, child: const Icon(Icons.tune))),
            ],
          ),
         Expanded(
           child: ListView.separated(
            itemCount: doctors.length ,
            shrinkWrap: true,
            itemBuilder: (context, index) {
           
             return doctors[index];
           }, separatorBuilder: (BuildContext context, int index) => SizedBox( height: 16.h,),  ),
         )
          // ListView()
          // const Row(),
        ]),
      ),
    );
  }
}

class UpcomingScheduleCard extends StatelessWidget {
  const UpcomingScheduleCard({
    super.key, required this.name, required this.specialization, required this.date, required this.time,
  });
final String name, specialization, date, time;
  @override
  Widget build(BuildContext context) {
    return Container(
                height: 0.23.sh,
                width: double.infinity,
                decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.r), color: ProjectColors.primaryColor),
                child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
       ListTile(
        leading: const CircleAvatar(),
        title: Text(name, style: const TextStyle(color: Colors.white),),
        subtitle: Text(specialization, style: const TextStyle(color: Colors.white),),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 0.5.sw,
            child:  ListTile(
              title: Text(date,style: const TextStyle(color: Colors.white),),
              subtitle: Text(time,style: const TextStyle(color: Colors.white),),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Image.asset(ProjectImages.contact))
        ],
      )
    ],
                ),
              );
  }
}

class DoctorsListTile extends StatelessWidget {
  const DoctorsListTile({
    super.key, required this.name, required this.specialization,
  });
final String name, specialization;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      title:  Text(name),
      subtitle: Text(specialization),
      leading: const CircleAvatar(),
      trailing: IconButton(
          onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined)),
    );
  }
}
