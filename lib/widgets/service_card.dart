import 'package:flutter/material.dart';
import 'package:flutter_app/models/category_model.dart';
import 'package:flutter_app/screens/service_salon_screen.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(this.category, {super.key});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                ServiceSalonScreen(serviceName: category.name),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            shape: const CircleBorder(),
            child: Container(
              height: 88,
              width: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    category.imageUrl,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Text(
            category.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
