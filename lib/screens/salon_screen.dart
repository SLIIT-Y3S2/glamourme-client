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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "See more",
                              style: TextStyle(fontSize: 16),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (salon.services != null)
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => BookServiceCard(
                        service: salon.services![index],
                        closingTime: salon.closingTime,
                        openingTime: salon.openingTime,
                        salonId: salon.salonId!,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      itemCount: salon.services!.length,
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
