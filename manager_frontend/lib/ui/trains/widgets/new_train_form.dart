import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manager_frontend/data/model/route.dart';
import 'package:manager_frontend/data/model/train.dart';
import 'package:manager_frontend/ui/trains/bloc/trains_bloc.dart';

class NewTrainForm extends StatefulWidget {
  const NewTrainForm({super.key});

  @override
  State<NewTrainForm> createState() => _NewTrainFormState();
}

class _NewTrainFormState extends State<NewTrainForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _firstClassSeatNumController =
      TextEditingController();
  final TextEditingController _secondClassSeatNumController =
      TextEditingController();
  final TextEditingController _thirdClassSeatNumController =
      TextEditingController();

  TrainType? _selectedTrainType;
  RouteModel? _selectedRoute;

  DateTime? _selectedDate;

  late RoutesListModel routesList;
  late TrainTypesList trainTypesList;

  @override
  void dispose() {
    _nameController.dispose();
    _speedController.dispose();
    _firstClassSeatNumController.dispose();
    _secondClassSeatNumController.dispose();
    _thirdClassSeatNumController.dispose();

    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainsBloc, TrainsState>(
      listener: (context, state) {
        if (state is TrainOperationSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context); // Close dialog on success
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Train created successfully')),
          );
        }
        if (state is TrainsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is TrainCreationLoaded) {
          trainTypesList = state.trainTypesList;
          routesList = state.routesList;
          return AlertDialog(
            title: const Text('Add New Train'),
            content: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 500, maxWidth: 1000),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Train Name*',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _speedController,
                        decoration: const InputDecoration(
                          labelText: 'Train Speed*',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstClassSeatNumController,
                              decoration: const InputDecoration(
                                labelText: 'First class seats number*',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a value';
                                }
                                final number = int.tryParse(value);
                                if (number == null) {
                                  return 'Please enter an integer';
                                }

                                return null;
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _secondClassSeatNumController,
                              decoration: const InputDecoration(
                                labelText: 'Second class seats number*',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a value';
                                }
                                final number = int.tryParse(value);
                                if (number == null) {
                                  return 'Please enter an integer';
                                }

                                return null;
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _thirdClassSeatNumController,
                              decoration: const InputDecoration(
                                labelText: 'Third class seats number*',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a value';
                                }
                                final number = int.tryParse(value);
                                if (number == null) {
                                  return 'Please enter an integer';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Date Field
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Train Purchase Date*',
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'Select date'
                                    : DateFormat(
                                      'yyyy-MM-dd hh:mm:ss',
                                    ).format(_selectedDate!),
                              ),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<int>(
                        value: _selectedTrainType?.id,
                        decoration: const InputDecoration(
                          labelText: 'Train Type*',
                        ),
                        items:
                            trainTypesList!.types!
                                .map(
                                  (type) => DropdownMenuItem(
                                    value: type.id,
                                    child: Text(type.title!),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedTrainType = trainTypesList!.types!
                                .firstWhere((type) => type.id == value);
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select Type';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        value: _selectedRoute?.id,
                        decoration: const InputDecoration(
                          labelText: 'Assigned Route*',
                        ),
                        items:
                            routesList!.routes!
                                .map(
                                  (route) => DropdownMenuItem(
                                    value: route.id,
                                    child: Text(route.title!),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedRoute = routesList!.routes!.firstWhere(
                              (route) => route.id == value,
                            );
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select Type';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed:
                    () => {
                      Navigator.pop(context),
                      context.read<TrainsBloc>().add(LoadTrains()),
                    },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final trainData = TrainCreate(
                      name: _nameController.text,
                      purchaseDate: DateFormat(
                        'yyyy-MM-dd hh:mm:ss',
                      ).format(_selectedDate!),
                      speed: int.tryParse(_speedController.text),
                      firstClassSeatNum: int.tryParse(
                        _firstClassSeatNumController.text,
                      ),
                      secondClassSeatNum: int.tryParse(
                        _secondClassSeatNumController.text,
                      ),
                      thirdClassSeatNum: int.tryParse(
                        _thirdClassSeatNumController.text,
                      ),
                      routeID: _selectedRoute!.id,
                      trainTypeID: _selectedTrainType!.id,
                    );

                    context.read<TrainsBloc>().add(CreateTrain(trainData));
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
