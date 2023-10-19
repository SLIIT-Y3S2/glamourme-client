import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/appointment/appointment_bloc.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/models/appointment_model.dart';
import 'package:flutter_app/screens/past_bookings_screen.dart';
import 'package:flutter_app/screens/upcoming_bookings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentIndexScreen extends StatefulWidget {
  const AppointmentIndexScreen({super.key});

  @override
  State<AppointmentIndexScreen> createState() => _AppointmentIndexScreenState();
}

class _AppointmentIndexScreenState extends State<AppointmentIndexScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  List<AppointmentModel> _upcomingAppointments = [];
  List<AppointmentModel> _pastAppointments = [];

  final List<Widget> _appointmentIndexedScreenTabs = const [
    Tab(text: 'Past'),
    Tab(text: 'Upcoming'),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: _appointmentIndexedScreenTabs.length, vsync: this);

    BlocProvider.of<AuthenticationBloc>(context)
        .add(const GetCurrentUserEvent());

    final authState = BlocProvider.of<AuthenticationBloc>(context).state;
    String? userId = BlocProvider.of<AuthenticationBloc>(context).userId;

    BlocProvider.of<AppointmentBloc>(context)
        .add(GetAppointmentsEvent(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _appointmentIndexedScreenTabs,
        ),
      ),
      body: BlocListener<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentsLoaded) {
            setState(() {
              _upcomingAppointments = state.appointments
                  .where((element) =>
                      element.startTime.toDate().isAfter(DateTime.now()))
                  .toList();

              _pastAppointments = state.appointments
                  .where((element) =>
                      element.startTime.toDate().isBefore(DateTime.now()))
                  .toList();
            });
          }
        },
        child: TabBarView(
          controller: _tabController,
          children: [
            // if (state is! AppointmentsLoaded)
            //   const CircularProgressIndicator.adaptive(),

            _pastAppointments.isNotEmpty
                ? PastBookingsScreen(appointments: _pastAppointments)
                : const Center(
                    child: Text('No past appointments'),
                  ),
            _upcomingAppointments.isNotEmpty
                ? UpcomingBookingsScreen(appointments: _upcomingAppointments)
                : const Center(
                    child: Text('No upcoming appointments'),
                  ),
          ],
        ),
      ),
    );
  }
}
