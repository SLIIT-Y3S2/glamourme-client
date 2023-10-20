import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/appointment_model.dart';

class PastBookingsScreen extends StatelessWidget {
  const PastBookingsScreen({super.key, required this.appointments});
  final List<AppointmentModel> appointments;

  String timeStampToString(Timestamp timestamp) {
    var date = timestamp.toDate();
    switch (date.month) {
      case 1:
        return '${date.day} Jan ${date.year}';
      case 2:
        return '${date.day} Feb ${date.year}';
      case 3:
        return '${date.day} Mar ${date.year}';
      case 4:
        return '${date.day} Apr ${date.year}';
      case 5:
        return '${date.day} May ${date.year}';
      case 6:
        return '${date.day} Jun ${date.year}';
      case 7:
        return '${date.day} Jul ${date.year}';
      case 8:
        return '${date.day} Aug ${date.year}';
      case 9:
        return '${date.day} Sep ${date.year}';
      case 10:
        return '${date.day} Oct ${date.year}';
      case 11:
        return '${date.day}/Nov/${date.year}';
      case 12:
        return '${date.day} Dec ${date.year}';
      default:
        return '${date.day} ${date.month} ${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return Card(
          surfaceTintColor: Colors.white,
          elevation: 1,
          child: ListTile(
            title: Text(
              'Salon Name',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Appointment $index'),
                Text('${appointments[index].title}'),
                Text(
                  timeStampToString(appointments[index].startTime),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      surfaceTintColor: Colors.white,
                    ),
                    child: Text(
                      'Rate Appointment',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
