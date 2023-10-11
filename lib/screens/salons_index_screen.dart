import 'package:flutter/material.dart';
import 'package:flutter_app/data/dummy_salon.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/widgets/salon_card.dart';

class SalonsIndexScreen extends StatelessWidget {
  const SalonsIndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: salonsNavigatorKey,
      appBar: AppBar(
          title: Text(
        'Salons',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w900,
            ),
      )),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: salonList.length,
              itemBuilder: (BuildContext context, int index) {
                return SalonCard(
                  salon: salonList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
