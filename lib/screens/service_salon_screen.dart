import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/salons/salons_bloc.dart';
import 'package:flutter_app/models/salon_model.dart';
import 'package:flutter_app/widgets/salon_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceSalonScreen extends StatelessWidget {
  const ServiceSalonScreen({
    super.key,
    required this.serviceName,
  });
  final String serviceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          serviceName,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
      ),
      body: BlocBuilder<SalonsBloc, SalonsState>(
        builder: (context, state) {
          final List<SalonModel> salonList = [];
          if (state is LoadedSalons) {
            if (state.salons.isNotEmpty) {
              for (var salon in state.salons) {
                for (var category in salon.categories) {
                  if (category.name == serviceName) {
                    salonList.add(salon);
                  }
                }
              }
            }
          }

          return state is LoadedSalons
              ? salonList.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      itemBuilder: (context, index) =>
                          SalonCard(salon: salonList[index]),
                      itemCount: salonList.length,
                    )
                  : const Center(child: Text('No salons found'))
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
