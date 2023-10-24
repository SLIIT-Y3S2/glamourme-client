import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/salons/salons_bloc.dart';
import 'package:flutter_app/widgets/salon_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllSalonsScreen extends StatelessWidget {
  const AllSalonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalonsBloc, SalonsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salons',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<SalonsBloc>(context).add(const GetSalonsEvent());
              return Future.delayed(
                const Duration(seconds: 2),
              );
            },
            child: state is LoadedSalons
                ? ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      title: SalonCard(salon: state.salons[index]),
                    ),
                    itemCount: state.salons.length,
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
