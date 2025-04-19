import 'package:customer_frontend/ui/reservation/trains/widgets/trains_list_item.dart';
import 'package:flutter/material.dart';

class TrainsList extends StatelessWidget {
  const TrainsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (ctx, index) {
        return TrainsListItem();
      },
    );
  }
}

