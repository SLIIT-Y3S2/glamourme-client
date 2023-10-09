import 'package:flutter/material.dart';
import 'package:flutter_app/models/service_model.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(this.service, {super.key});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: const CircleBorder(),
          child: InkWell(
            child: Container(
              height: 88,
              width: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    service.imageUrl,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Text(
          service.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
