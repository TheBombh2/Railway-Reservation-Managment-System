import 'package:customer_frontend/ui/reservation/trains/bloc/trains_bloc.dart';
import 'package:customer_frontend/ui/reservation/trains/widgets/trains_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainsList extends StatelessWidget {
  const TrainsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainsBloc, TrainsState>(
      builder: (context, state) {
        if (state is TrainsLoading) {
          return CircularProgressIndicator();
        }
        if (state is TrainsLoaded) {
          return ListView.builder(
            itemCount: state.trainsList.size,
            itemBuilder: (ctx, index) {
              return TrainsListItem(state.trainsList.trains![index],state.firstStation,state.secondStation);
            },
          );
        }

        return Text("Select Two Stations");
      },
    );
  }
}
