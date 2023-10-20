import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/appointment/appointment_bloc.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/models/appointment_model.dart';
import 'package:flutter_app/models/service_model.dart';
import 'package:flutter_app/widgets/time_pill.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaceAppointmentScreen extends StatefulWidget {
  final String salonId;
  final ServiceModel service;
  final Timestamp openingTime;
  final Timestamp closingTime;
  const PlaceAppointmentScreen({
    required this.service,
    required this.openingTime,
    required this.closingTime,
    super.key,
    required this.salonId,
  });

  @override
  State<PlaceAppointmentScreen> createState() => _PlaceAppointmentScreenState();
}

class _PlaceAppointmentScreenState extends State<PlaceAppointmentScreen> {
  int _selectedYear = DateTime.now().year;
  String _selectedTime = '';
  int? _hour;
  int? _minute;
  int _day = DateTime.now().day;
  int _month = DateTime.now().month;
  int? _year = DateTime.now().year;
  String? customerId;

  @override
  void initState() {
    developer.log('initState', name: 'PlaceAppointmentScreen');
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context)
        .add(const GetCurrentUserEvent());

    // if (authState is CurrentUserState) {
    //   if (authState.user == null) {
    //     developer.log('user is null', name: 'user');
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text('Please login to continue'),
    //       ),
    //     );
    //   } else {
    //     customerId = authState.user!.userId;
    //     developer.log(authState.user!.userId, name: 'userId');

    //     return;
    //   }
    // } else {
    //   BlocProvider.of<AuthenticationBloc>(context)
    //       .add(const GetCurrentUserEvent());
    // }
  }

  Timestamp? _setApppointmentStart() {
    if (_hour != null && _minute != null) {
      return Timestamp.fromDate(
          DateTime(_year!, _month, _day, _hour!, _minute!));
    }
    return null;
  }

  Timestamp? _setApppointmentEndTime() {
    int serviceDuration = int.parse(widget.service.duration);
    if (_hour != null && _minute != null) {
      return Timestamp.fromDate(
          DateTime(_year!, _month, _day, _hour!, _minute! + serviceDuration));
    }
    return null;
  }

  _handleCreateAppointment() {
    final Timestamp? startTime = _setApppointmentStart();
    final Timestamp? endTime = _setApppointmentEndTime();
    developer.log(startTime.toString(), name: 'startTime');
    developer.log(endTime.toString(), name: 'endTime');
    final String title = widget.service.name;
    final String description = widget.service.description;
    const String status = 'pending';
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;

    if (authState is CurrentUserState) {
      if (authState.user == null) {
        developer.log('user is null', name: 'user');
        Navigator.of(context).pushNamed('/login');
        return;
      } else {
        customerId = authState.user!.userId;
      }
    }

    if (startTime == null || endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time'),
        ),
      );
      return;
    }
    final AppointmentModel appointment = AppointmentModel.init(
        serviceId: widget.service.id,
        customerId: customerId!,
        salonId: widget.salonId,
        startTime: startTime,
        endTime: endTime,
        title: title,
        description: description,
        status: status);
    BlocProvider.of<AppointmentBloc>(context)
        .add(CreateAppointmentEvent(appointment: appointment));
  }

  @override
  Widget build(BuildContext context) {
    final DateTime openingTime = widget.openingTime.toDate();
    final DateTime closingTime = widget.closingTime.toDate();
    final int timeDiffInMin = closingTime.difference(openingTime).inMinutes;
    final int hourDiff = (timeDiffInMin / 60).ceil();

    Widget checkoutButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: _handleCreateAppointment,
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
            AppLocalizations.of(context)!.checkout,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );

    Widget bottomWidget = checkoutButton;
    return BlocListener<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentCreatedState) {
          Navigator.of(context).pop();
        }

        if (state is AppointmentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );

          bottomWidget = checkoutButton;
        }

        if (state is CreatingAppointmentState) {
          bottomWidget = const CircularProgressIndicator();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.appointment,
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
                        _day = date.day;
                        _month = date.month;
                        _year = date.year;
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
                    AppLocalizations.of(context)!.selectTime,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 4.5,
                    ),
                    itemBuilder: (context, index) {
                      final hour = widget.openingTime.toDate().hour + index;
                      final minute = widget.openingTime.toDate().minute;
                      final time =
                          '${(widget.openingTime.toDate().hour + index).toString().padLeft(2, '0')}:${openingTime.minute.toString().padLeft(2, '0')}';
                      return TimePill(
                        selected: time == _selectedTime,
                        onPressSelect: () {
                          setState(() {
                            _hour = hour;
                            _minute = minute;
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
              bottomWidget,
            ],
          ),
        ),
      ),
    );
  }
}
