import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/appointment/appointment_bloc.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/models/appointment_model.dart';
import 'package:flutter_app/screens/past_bookings_screen.dart';
import 'package:flutter_app/screens/upcoming_bookings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    String? userId = BlocProvider.of<AuthenticationBloc>(context).userId;

    BlocProvider.of<AppointmentBloc>(context)
        .add(GetAppointmentsEvent(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appointments,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
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
            _pastAppointments.isNotEmpty
                ? PastBookingsScreen(appointments: _pastAppointments)
                :  Center(
                    child: Text(AppLocalizations.of(context)!.nopastappointments),
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
