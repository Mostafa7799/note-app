import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bussiness_logic/cubit/cubit.dart';
import '../../bussiness_logic/cubit/states.dart';
import '../components/task_builder.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var tasks = AppCubit.get(context).newTasks;
        return TaskBuilder(
            tasks: tasks,
        );
      },
    );
  }
}
