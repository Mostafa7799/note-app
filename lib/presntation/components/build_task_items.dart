import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bussiness_logic/cubit/cubit.dart';

class BuildTasksItems extends StatefulWidget {
  const BuildTasksItems({Key? key, required this.model}) : super(key: key);
  final Map model;
  @override
  State<BuildTasksItems> createState() => _BuildTasksItemsState();
}

class _BuildTasksItemsState extends State<BuildTasksItems> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Text(
              '${widget.model['time'] }',
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.model['title']}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.model['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            IconButton(
              icon: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: widget.model['id'],
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.archive,
                color: Colors.black54,
              ),
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'archive',
                  id: widget.model['id'],
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.black54,
              ),
              onPressed: () {
                AppCubit.get(context).deleteData(
                  id: widget.model['id'],
                );
              },
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(
          id: widget.model['id'],
        );
      },
    );
  }
}
