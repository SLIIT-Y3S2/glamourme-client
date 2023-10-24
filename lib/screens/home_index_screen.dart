import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/location/location_bloc.dart';
import 'package:flutter_app/blocs/salons/salons_bloc.dart';
import 'package:flutter_app/data/service_categories.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/screens/all_salons_screen.dart';
import 'package:flutter_app/screens/beauty_services_list_screens.dart';
import 'package:flutter_app/widgets/near_you_card.dart';
import 'package:flutter_app/widgets/service_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              '${AppLocalizations.of(context)!.beautyServices} (${categoryData.sublist(0, 6).length})',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BeautyServicesListScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.keyboard_arrow_right),
                label: Text(AppLocalizations.of(context)!.seeAll),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) => ServiceCard(categoryData[index]),
          itemCount: categoryData.length > 6
              ? categoryData.sublist(0, 6).length
              : categoryData.length,
        ),
      ],
    );

    // Popular Near You Widget
    Widget popularNearYou = BlocBuilder<SalonsBloc, SalonsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: state is LoadedSalons
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.popularNearYou,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const AllSalonsScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.keyboard_arrow_right),
                            label: Text(AppLocalizations.of(context)!.seeAll),
                          ),
                        ),
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
                                  ...state.salons.map(
                                    (salon) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: NearYouCard(salon),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
        );
      },
    );

    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Scaffold(
          key: homeNavigatorKey,
          appBar: AppBar(
            title: state is LocationLoaded
                ? TextButton.icon(
                    onPressed: () {
                      BlocProvider.of<LocationBloc>(context)
                          .add(const GetLocationEvent());
                    },
                    icon: const Icon(Icons.location_on_outlined),
                    label: Text(state.location.address),
                  )
                : state is GettingLocation
                    ? TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.location_searching_outlined),
                        label: const Text('Getting Location'),
                      )
                    : TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.location_off_outlined),
                        label: const Text('Select Location'),
                      ),
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
