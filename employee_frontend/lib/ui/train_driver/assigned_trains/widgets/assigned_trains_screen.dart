import 'package:employee_frontend/ui/train_driver/assigned_trains/widgets/assigned_trains_list.dart';
import 'package:employee_frontend/ui/train_driver/assigned_trains/widgets/from_to_information_box.dart';
import 'package:flutter/material.dart';

class AssignedTrainsScreen extends StatefulWidget {
  const AssignedTrainsScreen({super.key});

  @override
  State<AssignedTrainsScreen> createState() => _AssignedTrainsScreenState();
}

class _AssignedTrainsScreenState extends State<AssignedTrainsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      showTrainsList();
    });
  }

  void showTrainsList() {
    showModalBottomSheet(
        barrierColor: Color.fromRGBO(0, 0, 0, 0),
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        useSafeArea: true,
        enableDrag: true,
        builder: (ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 16),
                child: FromToInformationBox(fromCity: 'Rathmalana', toCity: 'Panadura'),
              ),
              Expanded(child: AssignedTrainsList()),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.train,
          color: Color(0xff0077CD),
          size: 60,
        ),
        onPressed: () {
          showTrainsList();
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/map_placeholder.png',
              ),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
