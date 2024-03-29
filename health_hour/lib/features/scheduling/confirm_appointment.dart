import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:health_hour/features/auhtenticate/signin/signin_page.dart';
import 'package:health_hour/features/auhtenticate/signup/signup_page.dart';
import 'package:health_hour/features/home/bottom_navbar.dart';
import 'package:health_hour/features/onboarding/model/appointment_model.dart';
import 'package:health_hour/features/onboarding/model/notification_model.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../common widgets/app_button.dart';
import '../../constants/constants.dart';
import 'package:intl/intl.dart';

class ConfirmAppointment extends ConsumerStatefulWidget {
  const ConfirmAppointment(
      {super.key, required this.doctor, required this.user});
  final Map<String, dynamic> doctor;
  final Map<String, dynamic> user;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfirmAppointmentState();
}

class _ConfirmAppointmentState extends ConsumerState<ConfirmAppointment> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? selectedTime;
  String? formattedDate;
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

// Extract hour, minute, and AM/PM indicator
    final hour = now.hour % 12; // Use modulo to get hour in 12-hour format
    final minute = now.minute;
    final period = now.hour >= 12 ? "pm" : "am";

// Format the time string
    final formattedTime =
        "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";

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
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Appointment',
                      style: ProjectConstants.regularColoredSubTitleText
                          .copyWith(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                    )),
                Card(
                  color: Colors.white,
                  child: TableCalendar(
                    rowHeight: 0.05.sh,
                    calendarFormat: CalendarFormat.week,
                    focusedDay: _selectedDay ?? _focusedDay,
                    currentDay: DateTime.now(),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                    ),
                    firstDay:
                        DateTime.now().subtract(const Duration(days: 500)),
                    lastDay: DateTime.now().add(const Duration(days: 1500)),
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    calendarStyle: CalendarStyle(
                      // todayDecoration: const BoxDecoration(color: ProjectColors.purple),
                      selectedDecoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      markerDecoration: BoxDecoration(
                          color: ProjectColors.primaryColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20)),
                      markerSize: 6,
                    ),
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
                    options: GroupButtonOptions(
                        buttonHeight: 0.04.sh,
                        groupingType: GroupingType.row,
                        borderRadius: BorderRadius.all(Radius.circular(11.r))),
                    onSelected: (value, index, isSelected) {
                      setState(() {
                        selectedTime = value;
                      });
                    },
                    buttons: const [
                      "09:00",
                      "09:30",
                      "10:30",
                      "11:00",
                      "11:30",
                      "12:00",
                      "12:30",
                      "13:00",
                      "13:30",
                      "14:00",
                      "14:30",
                      "15:00",
                      "15:30",
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.025.sh,
                ),
                AppButton(
                    onPressed: () async {
                      await appointmemntRef.add(
                        Appointment(
                          patientName: widget.user['fullName'],
                          patientId: widget.user['id'],
                          doctorName: widget.doctor['fullName'],
                          doctorId: widget.doctor['id'],
                          date: '$_selectedDay',
                          time: selectedTime!,
                          specialization: widget.doctor['specialization'],
                          status: 'pending',
                        ),
                      );
                      await notificationRef
                          .add(CustomNotification(
                            content:
                                'You just booked an appointment with Dr. ${widget.doctor['fullName']} for ${DateFormat('EEE, dd MMM').format(_selectedDay!)}, $selectedTime.',
                            time: formattedTime,
                            patientName: widget.user['fullName'],
                            patientId: widget.user['id'],
                            doctorName: widget.doctor['fullName'],
                            doctorId: widget.doctor['id'],
                          ))
                          .then(
                            (value) => showDialog(
                               barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor:
                                          ProjectColors.primaryColor,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.025.sh,
                                    ),
                                    const Text(
                                      'Your appointment has been booked successfully',
                                      textAlign: TextAlign.center,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNav(user:firebase
                                                          .currentUser!, userData: currentUserData!,)));
                                        },
                                        child: const Text('Go back home'))
                                  ],
                                ),
                              ),
                            ),
                          );
                    },
                    child: const Text('Confirm'))
              ]),
        ),
      ),
    );
  }
}
