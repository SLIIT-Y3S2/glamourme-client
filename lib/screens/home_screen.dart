import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/data/dummy_salon.dart';
import 'package:flutter_app/data/dummy_services.dart';
import 'package:flutter_app/screens/appointments_screen.dart';
import 'package:flutter_app/screens/payment_screen.dart';
import 'package:flutter_app/widgets/bottom_navigation.dart';
import 'package:flutter_app/widgets/near_you_card.dart';
import 'package:flutter_app/widgets/service_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _signOut(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(const SignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Beauty Services Widget
    Widget beautyServicesCard = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Beauty Services',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_right),
              label: const Text('See all'),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) =>
                      ServiceCard(serviceData[index]),
                  itemCount: serviceData.length,
                ),
              ),
            )
          ],
        ),
      ],
    );

    // Popular Near You Widget
    Widget popularNearYou = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Near You',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_right),
              label: const Text('See all'),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...salonList.map(
                        (salon) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: NearYouCard(salon),
                        ),
                      ),
                      ...salonList.map(
                        (salon) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: NearYouCard(salon),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {},
      child: Scaffold(
        bottomNavigationBar: const BottomNavigation(),
        appBar: AppBar(
          title: const Text('Location goes here'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  beautyServicesCard,
                  const SizedBox(
                    height: 20,
                  ),
                  popularNearYou,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Column(
//   children: [
//     ElevatedButton(
//       onPressed: () {
//         Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => PaymentScreen()));
//       },
//       child: Text('Go to payment'),
//     ),
//     ElevatedButton(
//       onPressed: () {
//         _signOut(context);
//       },
//       child: Text('Sign out'),
//     ),
//     ElevatedButton(
//       onPressed: () {
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => const AppointmentScreen()));
//       },
//       child: Text('Go to appointments'),
//     ),
//     ElevatedButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => AppointmentScreen()));
//         },
//         child: Text('Appointments')),
//   ],
// ),
