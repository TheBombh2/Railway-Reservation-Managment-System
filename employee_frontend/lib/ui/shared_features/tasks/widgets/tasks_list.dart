import 'package:employee_frontend/ui/shared_features/tasks/bloc/tasks_bloc.dart';
import 'package:employee_frontend/ui/shared_features/tasks/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state is TasksError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is TasksLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TasksLoaded) {
          return ListView.builder(
            itemCount: state.tasksList.size,
            itemBuilder: (ctx, index) {
              return TaskItem(
                task: state.tasksList.tasks![index],
              );
            },
          );
        }
        return const Center(
          child: Text("No tasks found"),
        );
      },
    );
  }
}
