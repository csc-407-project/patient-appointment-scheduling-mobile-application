import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
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
        child: SingleChildScrollView(
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
                        title:  Text('Dr. Kemi Owo', style:ProjectConstants.regularColoredTitleText,),
                        subtitle:  Text('Cardiologist and Surgeon', style: ProjectConstants.regularColoredSubTitleText
                            .copyWith(fontSize: 9.sp),),
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
          
                 Align(
                    alignment: Alignment.topLeft, child: Text('Appointment', style:ProjectConstants.regularColoredSubTitleText.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                Card(
                  color: Colors.white,
                  child: TableCalendar(
                    rowHeight: 0.05.sh,
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GroupButton(
                    isRadio: true,
                    options:  GroupButtonOptions(
                      buttonHeight: 0.04.sh,
                      groupingType: GroupingType.row,
                      borderRadius: BorderRadius.all(Radius.circular(11.r))
                    ),
                    onSelected: (value, index, isSelected) =>
                        debugPrint('$index button is selected, value is $value'),
                    buttons: const ["12:00", "13:00", "14:30", "18:00", "19:00", "21:40"],
                  ),
                ),
                SizedBox(
                  height: 0.025.sh,
                ),
                AppButton(
                    onPressed: () {
                     showDialog(context: context, builder: (context) =>  AlertDialog(
                      backgroundColor: Colors.white,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(onPressed: (){}, icon: const Icon(Icons.close))),
                          const CircleAvatar(backgroundColor: ProjectColors.primaryColor,child: const Icon(Icons.check, color: Colors.white,),),
                          SizedBox(
                  height: 0.025.sh,
                ),
                          const Text('Your appointment has been booked successfully', textAlign: TextAlign.center,),
                        ],
                      ),
                     ),);
                    },
                    child: const Text('Confirm'))
              ]),
        ),
      ),
    );
  }
}
