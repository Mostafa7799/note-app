import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/presntation/components/build_task_items.dart';

class TaskBuilder extends StatefulWidget {
  const TaskBuilder({Key? key, required this.tasks}) : super(key: key);

  final List<Map> tasks;

  @override
  State<TaskBuilder> createState() => _TaskBuilderState();
}

class _TaskBuilderState extends State<TaskBuilder> {
  @override
  Widget build(BuildContext context) {
    return  ConditionalBuilder(
      condition: widget.tasks.isNotEmpty,
      builder: (context) =>
          ListView.separated(
            itemBuilder: (context, index) =>
                BuildTasksItems(model: widget.tasks[index],),
            separatorBuilder: (context, index) =>
                Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
            itemCount: widget.tasks.length,
          ),
      fallback: (context) =>
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Image.asset(
                  'assets/images/history.png',
                  height: MediaQuery.of(context).size.height*.3,
                ),
                const Text(
                  'No Tasks Yet, Please Add Some Tasks',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
