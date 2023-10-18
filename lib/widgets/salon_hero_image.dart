import 'package:flutter/material.dart';
import 'package:flutter_app/app_locale.dart';
import 'package:flutter_app/models/salon_model.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:transparent_image/transparent_image.dart';

class SalonHeroImage extends StatelessWidget {
  const SalonHeroImage({required this.salon, super.key});
  final SalonModel salon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(salon.imageUrl),
          fit: BoxFit.cover,
          height: 300,
          width: double.infinity,
        ),
        Container(
          color: Colors.black54,
          height: 300,
        ),
        Positioned(
          bottom: 20,
          left: 40,
          right: 0,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    salon.salonType == SalonType.gents
                        ? AppLocale.gents.getString(context)
                        : salon.salonType == SalonType.ladies
                            ? AppLocale.ladies.getString(context)
                            : AppLocale.unisex.getString(context),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  Text(
                    salon.salonName,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        salon.location,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 8,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        salon.affordability == Affordability.affordable
                            ? '\$'
                            : '\$\$',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(width: 80),
                      Column(
                        children: [
                          const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          ),
                          Text(
                            AppLocale.favourite.getString(context),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(children: [
                    Text(
                      '${AppLocale.businessHrs.getString(context)} - ${salon.openingTime.toDate().hour.toString().padLeft(2, '0')}:${salon.openingTime.toDate().minute.toString().padLeft(2, '0')} - ${salon.closingTime.toDate().hour.toString().padLeft(2, '0')}:${salon.closingTime.toDate().minute.toString().padLeft(2, '0')}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ])
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
