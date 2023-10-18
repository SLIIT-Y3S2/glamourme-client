import 'package:flutter/material.dart';
import 'package:flutter_app/models/salon_model.dart';
import 'package:flutter_app/widgets/book_service_card.dart';
import 'package:flutter_app/widgets/salon_hero_image.dart';

class SalonScreen extends StatelessWidget {
  const SalonScreen({required this.salon, super.key});
  final SalonModel salon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: AppBar(
          iconTheme: Theme.of(context).iconTheme.copyWith(
                color: Colors.white,
              ),
          backgroundColor: Colors.transparent,
          flexibleSpace: SalonHeroImage(salon: salon),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Recommended',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {},
                        label: Text(
                          'View All',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w900),
                        ),
                        icon: const Icon(Icons.arrow_right),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.primary),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (salon.services != null)
                    ...salon.services!.map(
                      (service) => BookServiceCard(
                        service: service,
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
