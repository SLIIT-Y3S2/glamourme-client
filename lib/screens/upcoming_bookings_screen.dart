import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/appointment/appointment_bloc.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/models/appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingBookingsScreen extends StatefulWidget {
  const UpcomingBookingsScreen({super.key, required this.appointments});
  final List<AppointmentModel> appointments;

  @override
  State<UpcomingBookingsScreen> createState() => _UpcomingBookingsScreenState();
}

class _UpcomingBookingsScreenState extends State<UpcomingBookingsScreen> {
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
        return '${date.day} Nov ${date.year}';
      case 12:
        return '${date.day} Dec ${date.year}';
      default:
        return '${date.day} ${date.month} ${date.year}';
    }
  }

  void _onClickCancelAppointment(BuildContext context, int index) {
    BlocProvider.of<AppointmentBloc>(context).add(
      CancelAppointmentEvent(
        appointmentId: widget.appointments[index].id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentCanceledState) {
          BlocProvider.of<AppointmentBloc>(context).add(
            GetAppointmentsEvent(
              userId: BlocProvider.of<AuthenticationBloc>(context).userId,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Appointment canceled'),
            ),
          );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<AppointmentBloc>(context).add(
                GetAppointmentsEvent(
                    userId:
                        BlocProvider.of<AuthenticationBloc>(context).userId),
              );
              return Future.delayed(
                const Duration(seconds: 2),
              );
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: widget.appointments.length,
              itemBuilder: (context, index) {
                return Card(
                  surfaceTintColor: Colors.white,
                  elevation: 1,
                  child: ListTile(
                    title: Text(
                      widget.appointments[index].salonName!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.appointments[index].title),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          timeStampToString(
                              widget.appointments[index].startTime),
                        ),
                        //Check if appointment is scheduled within 24 hours from now
                        if (widget.appointments[index].endTime
                                .toDate()
                                .difference(DateTime.now())
                                .inDays >
                            0)
                          TextButton(
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Cancel Appointment'),
                                content: const Text(
                                    'Are you sure you want to cancel?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => _onClickCancelAppointment(
                                        context, index),
                                    child: state is! CancelingAppointmentState
                                        ? const Text(
                                            'OK',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          )
                                        : const CircularProgressIndicator(
                                            color: Colors.red,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            child: Text(
                              'Cancel Appointment',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700),
                            ),
                          ),
                      ],
                    ),
                    trailing: Text(
                        '${widget.appointments[index].appointmentPrice.toStringAsFixed(2)} LKR'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
