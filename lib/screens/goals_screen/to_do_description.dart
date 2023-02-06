import 'package:flutter/material.dart';
import 'package:meapp/models/to_do_model.dart';
import 'package:provider/provider.dart';

class TodoDescription extends StatefulWidget {
  final String? title;
  final String description;
  const TodoDescription({super.key, required this.description, this.title});

  @override
  State<TodoDescription> createState() => _TodoDescriptionState();
}

class _TodoDescriptionState extends State<TodoDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Description:'), //title fomart
          Text(widget.description),
          const Text('Deadline; You have this much time remaining'),
          const Text('Subtasks:'), //Title format
          Center(
            child: IconButton(
              icon: const Icon(
                Icons.add_circle,
                color: Colors.blue,
              ),
              color: Colors.blueAccent,
              onPressed: () => openDialog(),
            ),
          ),
        ],
      ),
    );
  }

  openDialog() => showDialog(
        context: context,
        builder: (context) {
          final goalProvider = Provider.of<TaskProvider>(context);
          TextEditingController goalTitleController = TextEditingController();
          TextEditingController goalDescriptionController =
              TextEditingController();
          TextEditingController deadlineController = TextEditingController();
          return AlertDialog(
            title: const Text('ADD goal'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: goalTitleController,
                  decoration: const InputDecoration(
                    hintText: 'goal Title',
                  ),
                ),
                TextFormField(
                  controller: goalDescriptionController,
                  decoration: const InputDecoration(
                    hintText: 'goal Description',
                  ),
                ),
                TextFormField(
                  controller: deadlineController,
                  decoration: const InputDecoration(
                    hintText: 'goal Description',
                  ),
                )
              ],
            ),
            actions: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        //Add a goal
                        goalProvider.myTaskTitle
                            .add(goalTitleController.text.trim());
                        goalProvider.myTaskDescription
                            .add(goalDescriptionController.text.trim());
                        //CLOSE AFTER
                        //Latest shown on top
                        //Upload Feature => close after upload, save photo somewhere,
                        //Perform CRUD operation on goal.
                        //Implement hive
                      },
                      child: const Text('ADD')),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ],
              )
            ],
          );
        },
      );
}
