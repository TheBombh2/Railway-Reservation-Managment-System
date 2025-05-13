import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/trains/widgets/new_train_form.dart';
import 'package:manager_frontend/ui/trains/widgets/new_train_type_form.dart';
import 'package:manager_frontend/ui/trains/widgets/trains_list.dart';

class TrainsFragment extends StatelessWidget {
  const TrainsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Trains Management",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Spacer(),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: darkerBlue,
                      surfaceTintColor: darkerBlue,
                    ),
                    icon: Icon(Icons.train_outlined, color: darkBlue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => NewTrainForm(),
                      );
                    },
                    label: Text(
                      'Add a Train',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                  ),
                 SizedBox(width: 20,),
                 OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: darkerBlue,
                      surfaceTintColor: darkerBlue,
                    ),
                    icon: Icon(Icons.create_outlined, color: darkBlue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => NewTrainTypeForm(),
                      );
                    },
                    label: Text(
                      'Create Train Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                  ),
                
                ],
              ),

              const SizedBox(height: 16),
              const TrainsList(),
            ],
          ),
        ),
      ),
    );
  }
}
