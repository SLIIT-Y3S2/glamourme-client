import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_app/models/service_model.dart';
import 'package:flutter_app/widgets/time_pill.dart';

class PlaceAppointmentScreen extends StatefulWidget {
  final ServiceModel service;
  final Timestamp openingTime;
  final Timestamp closingTime;
  const PlaceAppointmentScreen({
    required this.service,
    required this.openingTime,
    required this.closingTime,
    super.key,
  });

  @override
  State<PlaceAppointmentScreen> createState() => _PlaceAppointmentScreenState();
}

class _PlaceAppointmentScreenState extends State<PlaceAppointmentScreen> {
  int _selectedYear = DateTime.now().year;
  String _selectedTime = '';
  @override
  Widget build(BuildContext context) {
    final DateTime openingTime = widget.openingTime.toDate();
    final DateTime closingTime = widget.closingTime.toDate();
    final int timeDiffInMin = closingTime.difference(openingTime).inMinutes;
    final int hourDiff = (timeDiffInMin / 60).ceil();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Date Picker
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedYear.toString(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 12),
                DatePicker(
                  DateTime.now(),
                  height: 100,
                  selectionColor: Theme.of(context).colorScheme.primary,
                  initialSelectedDate: DateTime.now(),
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedYear = date.year;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Time Picker
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Time',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 4.5,
                  ),
                  itemBuilder: (context, index) {
                    final time =
                        '${widget.openingTime.toDate().hour + index}:${openingTime.minute}';
                    return TimePill(
                      selected: time == _selectedTime,
                      onPressSelect: () {
                        setState(() {
                          _selectedTime = time;
                        });
                      },
                      time: time,
                    );
                  },
                  itemCount: hourDiff,
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 8,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    '\$${widget.service.price}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    'Check Availability',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
