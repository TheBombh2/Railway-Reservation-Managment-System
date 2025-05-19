import 'package:customer_frontend/data/model/station.dart';

import 'package:customer_frontend/ui/reservation/trains/bloc/trains_bloc.dart';
import 'package:customer_frontend/ui/reservation/trains/widgets/from_to_information_box.dart';
import 'package:customer_frontend/ui/reservation/trains/widgets/trains_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainsScreen extends StatefulWidget {
  TrainsScreen({super.key});

  @override
  State<TrainsScreen> createState() => _TrainsScreenState();
}

class _TrainsScreenState extends State<TrainsScreen> {
  late final StationsListModel? stationsList;

  Station fromCity = Station(name: "Not Selected");

  Station toCity = Station(name: "Not Selected");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: BlocConsumer<TrainsBloc, TrainsState>(
              listener: (context, state) {
                if (state is StationsSelected) {
                  fromCity = state.fromStation;
                  toCity = state.toStation;
                }
              },
              builder: (context, state) {
                if (state is StationsLoading) {
                  Center(child: CircularProgressIndicator());
                } else {
                  return FromToInformationBox(
                    fromCity: fromCity.name!,
                    toCity: toCity.name!,
                  );
                }
                return Text("Please reopen");
              },
            ),
          ),
          Expanded(flex: 2, child: TrainsList()),
        ],
      ),
    );
  }
}
