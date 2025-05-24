import 'package:employee_frontend/data/model/task.dart';
import 'package:employee_frontend/ui/shared_features/tasks/bloc/tasks_bloc.dart';
import 'package:employee_frontend/ui/shared_features/tasks/widgets/task_item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          useSafeArea: true,
          enableDrag: true,
          builder: (ctx) {
            final bloc = context.read<TasksBloc>();
            return BlocProvider.value(
              value: bloc,
              child: TaskItemDetails(task: task),
            );
          }),
      splashColor: Color(0xffF3F5FF),
      hoverColor: Color(0xffF3F5FF),
      focusColor: Color(0xffF3F5FF),
      contentPadding: EdgeInsets.all(20),
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: Color(0xffE9F3F9), borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Icon(
            Icons.task_outlined,
            color: Color(0xff0077CD),
            size: 46,
          ),
        ),
      ),
      title: Text(
        task.title!,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 0.7)),
      ),
    );
  }
}
