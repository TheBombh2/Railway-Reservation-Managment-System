import 'package:customer_frontend/data/model/station.dart';
import 'package:customer_frontend/ui/reservation/trains/bloc/trains_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StationSelectionScreen extends StatefulWidget {
  bool isFromCity;
  StationSelectionScreen(this.isFromCity, {super.key});

  @override
  _StationSelectionScreenState createState() => _StationSelectionScreenState();
}

class _StationSelectionScreenState extends State<StationSelectionScreen> {
  StationsListModel allStations = StationsListModel();
  List<Station> filteredStations = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<TrainsBloc>().add(LoadStations());

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Color(0xff0076CB)),
        title: Text(
          'Select ${widget.isFromCity ? "From" : "To"} Station',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xff0076CB),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Color(0xffFFFBFB)),
                child: BlocConsumer<TrainsBloc, TrainsState>(
                  listener:(context, state) {
                    if(state is StationOperationSuccess){
                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    if (state is StationsLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is StationsLoaded) {
                      allStations = state.stationsList;
                      filteredStations = allStations.stations!;

                      return ListView.builder(
                        itemCount: filteredStations.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              context.read<TrainsBloc>().add(
                                SelectStations(
                                  station: filteredStations[index],
                                  isFrom: widget.isFromCity,
                                ),
                              );
                            },
                            title: Text(
                              filteredStations[index].name!,
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: Text("Please reopen"));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
