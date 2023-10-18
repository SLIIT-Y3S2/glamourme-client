import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/appointment/appointment_bloc.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentIndexScreen extends StatelessWidget {
  const AppointmentIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(const GetCurrentUserEvent());
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;
    String? userId = BlocProvider.of<AuthenticationBloc>(context).userId;
    if (authState is CurrentUserState) {
      if (authState.user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please login to continue'),
          ),
        );
      } else {
        userId = authState.user!.userId;
      }
    }

    if (userId != null) {
      BlocProvider.of<AppointmentBloc>(context)
          .add(GetAppointmentsEvent(userId: userId));
    }

    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Appointments')),
          body: Column(children: [
            if (state is LoadingAppoinments)
              const Center(child: CircularProgressIndicator())
            else if (state is AppointmentsLoaded)
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.appointments.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state.appointments[index].title),
                      subtitle: Text('Appointment $index'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {},
                    ),
                  );
                },
              )
          ]),
        );
      },
    );
  }
}
