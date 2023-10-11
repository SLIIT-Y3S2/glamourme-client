import 'package:flutter/material.dart';
import 'package:flutter_app/models/salon_model.dart';
import 'package:flutter_app/screens/salon_screen.dart';

class SalonCard extends StatelessWidget {
  const SalonCard({required this.salon, super.key});
  final SalonModel salon;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: Color.fromARGB(1, 234, 235, 236),
        ),
      ),
      surfaceTintColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SalonScreen(
                salon: salon,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/image 4.png',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    salon.salonName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  subtitle: Text(salon.location),
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('4.9'),
                      SizedBox(width: 8),
                      Icon(Icons.star,
                          color: Color.fromARGB(255, 253, 232, 40)),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
