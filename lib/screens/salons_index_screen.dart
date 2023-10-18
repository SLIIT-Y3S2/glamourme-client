import 'package:flutter/material.dart';
import 'package:flutter_app/app_locale.dart';
import 'package:flutter_app/blocs/salons/salons_bloc.dart';
import 'package:flutter_app/data/dummy_salon.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/widgets/salon_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

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
            AppLocale.salons.getString(context),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          )),
          body: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state is LoadingSalons)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (state is LoadedSalons && state.salons.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.salons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SalonCard(
                        salon: state.salons[index],
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
