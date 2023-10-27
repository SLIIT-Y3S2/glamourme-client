import 'package:flutter/material.dart';
import 'package:flutter_app/models/salon_model.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalonHeroImage extends StatefulWidget {
  const SalonHeroImage({required this.salon, super.key});
  final SalonModel salon;

  @override
  State<SalonHeroImage> createState() => _SalonHeroImageState();
}

class _SalonHeroImageState extends State<SalonHeroImage> {
  bool _isFavourite = false;
  @override
  Widget build(BuildContext context) {
    final selectedDay = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ][DateTime.now().weekday - 1];

    final selectedOpeningHours = widget.salon.openingHours
        .firstWhere((element) => element.day == selectedDay);

    final openingTime = selectedOpeningHours.openingTime;
    final closingTime = selectedOpeningHours.closingTime;
    final isOpenToday = selectedOpeningHours.isOpen;

    return Stack(
      children: [
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(widget.salon.imageUrl),
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
                    widget.salon.salonType == GenderType.gents
                        ? AppLocalizations.of(context)!.gents
                        : widget.salon.salonType == GenderType.ladies
                            ? AppLocalizations.of(context)!.ladies
                            : AppLocalizations.of(context)!.unisex,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  Text(
                    widget.salon.salonName,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.salon.location,
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
                        widget.salon.affordability == Affordability.affordable
                            ? '\$'
                            : '\$\$',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(width: 80),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isOpenToday ? 'Open' : 'Closed',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          isOpenToday
                              ? Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '${openingTime.hour.toString().padLeft(2, '0')}:${openingTime.minute.toString().padLeft(2, '0')} - ${closingTime.hour.toString().padLeft(2, '0')}:${closingTime.minute.toString().padLeft(2, '0')}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 72,
                                    ),
                                  ],
                                )
                              : const SizedBox(
                                  width: 200,
                                ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _isFavourite = !_isFavourite;
                                });
                              },
                              icon: _isFavourite
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                          Text(
                            AppLocalizations.of(context)!.favourite,
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
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
