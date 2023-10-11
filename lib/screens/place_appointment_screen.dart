import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class PlaceAppointmentScreen extends StatefulWidget {
  const PlaceAppointmentScreen({super.key});

  @override
  State<PlaceAppointmentScreen> createState() => _PlaceAppointmentScreenState();
}

class _PlaceAppointmentScreenState extends State<PlaceAppointmentScreen> {
  int _selectedYear = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
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
                    return OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('${9 - 10 - index}:00 AM'),
                    );
                  },
                  itemCount: 10,
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 8,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                children: [
                  Text(
                    '\$40',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
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
