import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common widgets/app_button.dart';
import '../../constants/constants.dart';

class ConfirmAppointment extends ConsumerStatefulWidget {
  const ConfirmAppointment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfirmAppointmentState();
}

class _ConfirmAppointmentState extends ConsumerState<ConfirmAppointment> {
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
                          NetworkImage("https://via.placeholder.com/275x277"),
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
                      title: const Text('Dr. Kemi Owo'),
                      subtitle: const Text('Cardiologist and Surgeon'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber.shade300,
                          ),
                          const Text('4.9 (96 reviews)')
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const Align(
                  alignment: Alignment.topLeft, child: Text('Appointment')),
              Card(
                color: Colors.white,
                child: TableCalendar(
                  calendarFormat: CalendarFormat.week,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.now().subtract(const Duration(days: 500)),
                  lastDay: DateTime.now().add(const Duration(days: 1500)),
                ),
              ),
              SizedBox(
                height: 0.025.sh,
              ),
               const Align(
                  alignment: Alignment.topLeft, child: Text('Avaiable Time')),
                    SizedBox(
                height: 0.025.sh,
              ),
              AppButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ConfirmAppointment())),
                  child: const Text('Confirm'))
            ]),
      ),
    );
  }
}
