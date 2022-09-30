import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/presntation/components/task_builder.dart';
import '../../bussiness_logic/cubit/cubit.dart';
import '../../bussiness_logic/cubit/states.dart';


class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var tasks = AppCubit.get(context).archiveTasks;
        return TaskBuilder(
            tasks: tasks,
        );
      },
    );
  }
}
