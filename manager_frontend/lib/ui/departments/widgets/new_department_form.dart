import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/data/model/department.dart';
import 'package:manager_frontend/data/model/permission.dart';
import 'package:manager_frontend/data/model/subpermissionsData.dart';
import 'package:manager_frontend/ui/departments/bloc/departments_bloc.dart';

class NewDepartmentForm extends StatefulWidget {
  const NewDepartmentForm({super.key});

  @override
  State<NewDepartmentForm> createState() => _NewDepartmentFormState();
}

class _NewDepartmentFormState extends State<NewDepartmentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final Map<String, Set<String>> _selectedSubPermissions = {};
  String? _selectedGroup;

  late Permissions permissionsList;
  late SubPermissionsData subPermissionsList;

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DepartmentsBloc, DepartmentsState>(
      listener: (context, state) {
        if (state is DepartmentsOperationSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context); // Close dialog on success
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Department created successfully')),
          );
        }
        if (state is DepartmentsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is DepartmentsLoaded) {
          permissionsList = state.permissionsList;
          subPermissionsList = state.subPermissionsList;
        } else {
          return const Center(child: CircularProgressIndicator());
        }

        return AlertDialog(
          title: const Text('Add New Department'),
          content: SizedBox(
            height: 500,
            width: 900,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// LEFT SIDE - Permissions Menu
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Permissions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: permissionsList.size,
                          itemBuilder: (context, index) {
                            final permission =
                                permissionsList.permissions![index];
                            return ListTile(
                              title: Text(permission.name!),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedGroup = permission.name;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Selected Permissions:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 150,
                        child: ListView(
                          children:
                              _selectedSubPermissions.entries.expand((entry) {
                                final group = entry.key;
                                return entry.value.map(
                                  (perm) => ListTile(
                                    dense: true,
                                    title: Text('$group - $perm'),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.close, size: 16),
                                      onPressed: () {
                                        setState(() {
                                          _selectedSubPermissions[group]
                                              ?.remove(perm);
                                          if (_selectedSubPermissions[group]
                                                  ?.isEmpty ??
                                              true) {
                                            _selectedSubPermissions.remove(
                                              group,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                const VerticalDivider(width: 24),

                /// RIGHT SIDE - Form + SubPermissions
                Flexible(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Department Title*',
                              hintText: 'e.g., Research & Development',
                            ),
                            validator:
                                (value) =>
                                    (value == null || value.isEmpty)
                                        ? 'Required'
                                        : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _locationController,
                            decoration: const InputDecoration(
                              labelText: 'Location*',
                              hintText: 'e.g., Building A, Floor 3',
                            ),
                            validator:
                                (value) =>
                                    (value == null || value.isEmpty)
                                        ? 'Required'
                                        : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              hintText:
                                  'Brief description of department functions',
                              alignLabelWithHint: true,
                            ),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                          ),
                          const SizedBox(height: 24),
                          if (_selectedGroup != null) ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Select permissions for: $_selectedGroup',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  subPermissionsList.groups
                                      .where(
                                        (group) => group.name == _selectedGroup,
                                      )
                                      .expand(
                                        (
                                          group,
                                        ) => group.permissions.entries.map((
                                          entry,
                                        ) {
                                          final subPermission = entry.key;
                                          final isSelected =
                                              _selectedSubPermissions[_selectedGroup!]
                                                  ?.contains(subPermission) ??
                                              false;
                                          return CheckboxListTile(
                                            title: Text(subPermission),
                                            value: isSelected,
                                            onChanged: (bool? selected) {
                                              setState(() {
                                                if (selected == true) {
                                                  _selectedSubPermissions
                                                      .putIfAbsent(
                                                        _selectedGroup!,
                                                        () => <String>{},
                                                      )
                                                      .add(subPermission);
                                                } else {
                                                  _selectedSubPermissions[_selectedGroup!]
                                                      ?.remove(subPermission);
                                                  if (_selectedSubPermissions[_selectedGroup!]
                                                          ?.isEmpty ??
                                                      true) {
                                                    _selectedSubPermissions
                                                        .remove(
                                                          _selectedGroup!,
                                                        );
                                                  }
                                                }
                                              });
                                            },
                                          );
                                        }),
                                      )
                                      .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed:
                  state is DepartmentsLoading
                      ? null
                      : () {
                        if (_formKey.currentState!.validate()) {
                          final selectedPermissionNames =
                              _selectedSubPermissions.keys.toList();
                          final selectedPermissions =
                              permissionsList.permissions!
                                  .where(
                                    (perm) => selectedPermissionNames.contains(
                                      perm.name,
                                    ),
                                  )
                                  .toList();

                          final Map<String, Map<String, dynamic>>
                          formattedSubPermissions = {};

                          _selectedSubPermissions.forEach((
                            groupName,
                            subPermList,
                          ) {
                            final groupIndex = permissionsList.permissions!
                                .indexWhere((perm) => perm.name == groupName);

                            final subPermsWithValues = <String, dynamic>{
                              'index': groupIndex,
                            };

                            final subPermValues =
                                subPermissionsList.groups
                                    .firstWhere(
                                      (group) => group.name == groupName,
                                    )
                                    .permissions;

                            for (final subPerm in subPermList) {
                              final value = subPermValues[subPerm];
                              if (value != null) {
                                subPermsWithValues[subPerm] = value;
                              }
                            }

                            formattedSubPermissions[groupName] =
                                subPermsWithValues;
                          });

                          final departmentData = DepartmentCreate(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            location: _locationController.text,
                            permission: 0,
                            subPermission: BigInt.zero,
                          );

                          context.read<DepartmentsBloc>().add(
                            CreateDpeartment(
                              departmentData: departmentData,
                              permissions: selectedPermissions,
                              subPermissions: formattedSubPermissions,
                            ),
                          );
                        }
                      },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
