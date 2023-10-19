import 'package:flutter/material.dart';
import 'package:flutter_app/data/dummy_salon.dart';
import 'package:flutter_app/data/dummy_services.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/widgets/near_you_card.dart';
import 'package:flutter_app/widgets/service_card.dart';

class HomeIndexScreen extends StatefulWidget {
  const HomeIndexScreen({super.key});

  @override
  State<HomeIndexScreen> createState() => _HomeIndexScreenState();
}

class _HomeIndexScreenState extends State<HomeIndexScreen> {
  @override
  Widget build(BuildContext context) {
    // Beauty Services Widget
    Widget beautyServicesCard = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Beauty Services',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
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
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
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

    return Scaffold(
      key: homeNavigatorKey,
      appBar: AppBar(
        title: const Text('Location goes here'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                beautyServicesCard,
                const SizedBox(
                  height: 20,
                ),
                popularNearYou,
                const SizedBox(
                  height: 20,
                ),
                popularNearYou,
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
