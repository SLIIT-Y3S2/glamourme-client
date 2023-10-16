import 'package:flutter/material.dart';
import 'package:flutter_app/models/salon_model.dart';
import 'package:transparent_image/transparent_image.dart';

class NearYouCard extends StatelessWidget {
  const NearYouCard(this.salon, {super.key});
  final SalonModel salon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: FadeInImage(
            fit: BoxFit.cover,
            width: 270,
            height: 180,
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(salon.imageUrl),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              salon.salonType == SalonType.gents
                  ? 'Gents'
                  : salon.salonType == SalonType.ladies
                      ? 'Ladies'
                      : 'Unisex',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
            ),
            Text(
              salon.salonName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Row(
              children: [
                // if (salon.services.length > 3)
                //   ...salon.services
                //       .skip(3 - salon.services.length)
                //       .map((service) => Text(service.name.substring(0, 1))),
                // if (salon.services.length <= 3)
                if (salon.services != null)
                  ...salon.services!.map((service) => Text('${service.name} ')),

                Icon(
                  Icons.circle,
                  color: Colors.grey.shade500,
                  size: 8,
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.star_outline_rounded,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  salon.rating.toString(),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  salon.location,
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey.shade500,
                  size: 8,
                ),
                const SizedBox(
                  width: 4,
                ),
                salon.affordability == Affordability.affordable
                    ? const Text('\$')
                    : const Text('\$\$'),
              ],
            )
          ],
        ),
      ],
    );
  }
}
