import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/presntation/components/task_builder.dart';

import '../../bussiness_logic/cubit/cubit.dart';
import '../../bussiness_logic/cubit/states.dart';


class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var tasks = AppCubit.get(context).doneTasks;
        return TaskBuilder(
            tasks: tasks,
        );
      },
    );
  }
}
