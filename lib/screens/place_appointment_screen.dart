import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/appointment/appointment_bloc.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/models/appointment_model.dart';
import 'package:flutter_app/models/salon_model.dart';
import 'package:flutter_app/models/service_model.dart';
import 'package:flutter_app/widgets/time_pill.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaceAppointmentScreen extends StatefulWidget {
  final String salonId;
  final ServiceModel service;
  final List<OpeningHoursDataModel> openingHours;
  const PlaceAppointmentScreen({
    required this.service,
    required this.openingHours,
    super.key,
    required this.salonId,
  });

  @override
  State<PlaceAppointmentScreen> createState() => _PlaceAppointmentScreenState();
}

class _PlaceAppointmentScreenState extends State<PlaceAppointmentScreen> {
  late TimeOfDay _openingTime;
  late TimeOfDay _closingTime;
  late bool _isOpenInSelectedDay;
  int _selectedDayOfTheWeek = DateTime.now().weekday;
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
    developer.log('${_selectedDayOfTheWeek}', name: 'PlaceAppointmentScreen');
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context).add(
      const GetCurrentUserEvent(),
    );
    _selectDayOfTheWeek(_selectedDayOfTheWeek);
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

  final Logger logger = Logger('PaymentScreen');

  void _makePayment() {
    final Map<String, dynamic> _paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "merchant_id": "1222623",
      "merchant_secret":
          "MTU3ODI1NTEwNTMwMjE5NTM0NzAxODE0NTY1MDAxMjg2NzIzMDIxNg==", // See step 4e
      "notify_url": "http://sample.com/notify",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "amount": widget.service.price,
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "No. 46, Galle road, Kalutara South",
      "delivery_city": "Kalutara",
      "delivery_country": "Sri Lanka",
      "custom_1": "",
      "custom_2": ""
    };

    // PayHere.startPayment(_paymentObject, (paymentId) {
    //   logger.info('One Time Payment Success. Payment Id: $paymentId');
    //   _handleCreateAppointment();
    // }, (error) {
    //   logger.severe('One Time Payment Failed. Error: $error');
    // }, () {
    //   logger.info('One Time Payment Dismissed');
    // });
    _handleCreateAppointment();
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

  void _checkAvaiability() {
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
        .add(IsTimeSlotAvailableEvent(appointment: appointment));
    final appointmentState = BlocProvider.of<AppointmentBloc>(context).state;
    if (appointmentState is TimeSlotAvailableState) {
      if (appointmentState.isAvailable) {
        _makePayment();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Time slot is not available'),
          ),
        );
      }
    }
  }

  // Used to select the day of the week
  void _selectDayOfTheWeek(int day) {
    setState(() {
      _selectedDayOfTheWeek = day;
      switch (day) {
        case 1:
          _openingTime = widget.openingHours
              .where((element) => element.day == 'Monday')
              .first
              .openingTime;
          _closingTime = widget.openingHours
              .where((element) => element.day == 'Monday')
              .first
              .closingTime;
          _isOpenInSelectedDay = widget.openingHours
              .where((element) => element.day == 'Monday')
              .first
              .isOpen;
          break;
        case 2:
          _openingTime = widget.openingHours
              .where((element) => element.day == 'Tuesday')
              .first
              .openingTime;
          _closingTime = widget.openingHours
              .where((element) => element.day == 'Tuesday')
              .first
              .closingTime;
          _isOpenInSelectedDay = widget.openingHours
              .where((element) => element.day == 'Tuesday')
              .first
              .isOpen;
          break;
        case 3:
          _openingTime = widget.openingHours
              .where((element) => element.day == 'Wednesday')
              .first
              .openingTime;
          _closingTime = widget.openingHours
              .where((element) => element.day == 'Wednesday')
              .first
              .closingTime;
          _isOpenInSelectedDay = widget.openingHours
              .where((element) => element.day == 'Wednesday')
              .first
              .isOpen;
          break;
        case 4:
          _openingTime = widget.openingHours
              .where((element) => element.day == 'Thursday')
              .first
              .openingTime;
          _closingTime = widget.openingHours
              .where((element) => element.day == 'Thursday')
              .first
              .closingTime;
          _isOpenInSelectedDay = widget.openingHours
              .where((element) => element.day == 'Thursday')
              .first
              .isOpen;
          break;
        case 5:
          _openingTime = widget.openingHours
              .where((element) => element.day == 'Friday')
              .first
              .openingTime;
          _closingTime = widget.openingHours
              .where((element) => element.day == 'Friday')
              .first
              .closingTime;
          _isOpenInSelectedDay = widget.openingHours
              .where((element) => element.day == 'Friday')
              .first
              .isOpen;
          break;
        case 6:
          _openingTime = widget.openingHours
              .where((element) => element.day == 'Saturday')
              .first
              .openingTime;
          _closingTime = widget.openingHours
              .where((element) => element.day == 'Saturday')
              .first
              .closingTime;
          _isOpenInSelectedDay = widget.openingHours
              .where((element) => element.day == 'Saturday')
              .first
              .isOpen;
          break;
        case 7:
          _openingTime = widget.openingHours
              .where((element) => element.day == 'Sunday')
              .first
              .openingTime;
          _closingTime = widget.openingHours
              .where((element) => element.day == 'Sunday')
              .first
              .closingTime;
          _isOpenInSelectedDay = widget.openingHours
              .where((element) => element.day == 'Sunday')
              .first
              .isOpen;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime openingTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      _openingTime.hour,
      _openingTime.minute,
    );
    final DateTime closingTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      _closingTime.hour,
      _closingTime.minute,
    );
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
      onPressed: _checkAvaiability,
      child: Row(
        children: [
          Text(
            'LKR ${widget.service.price}',
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
                        _selectDayOfTheWeek(date.weekday);
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
                      final hour = _openingTime.hour + index;
                      final minute = _openingTime.minute;
                      final time =
                          '${(_openingTime.hour + index).toString().padLeft(2, '0')}:${_openingTime.minute.toString().padLeft(2, '0')}';
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
