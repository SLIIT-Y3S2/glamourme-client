import 'package:flutter/material.dart';
import 'package:flutter_app/data/service_categories.dart';
import 'package:flutter_app/widgets/service_card.dart';

class BeautyServicesListScreen extends StatelessWidget {
  const BeautyServicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beauty Services',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) => ServiceCard(categoryData[index]),
        itemCount: categoryData.length,
      ),
    );
  }
}
