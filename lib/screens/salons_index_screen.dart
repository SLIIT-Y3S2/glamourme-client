import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/salons/salons_bloc.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/widgets/near_by_salons_map.dart';
import 'package:flutter_app/widgets/salon_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalonsIndexScreen extends StatelessWidget {
  const SalonsIndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SalonsBloc>(context).add(const GetSalonsEvent());

    return BlocBuilder<SalonsBloc, SalonsState>(
      builder: (context, state) {
        return Scaffold(
          key: salonsNavigatorKey,
          appBar: AppBar(
              title: Text(
            'Salons',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const NearYouSalonsMap(),
                  if (state is LoadingSalons)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'Near By Salons',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 20),
                  if (state is LoadedSalons && state.salons.isNotEmpty)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.salons.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SalonCard(
                          salon: state.salons[index],
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
