import 'package:flutter/material.dart';
import 'package:meapp/const/to_do_view.dart';
import 'package:meapp/view_model/to_do_model.dart';
import 'package:provider/provider.dart';

class TODOPAGE extends StatefulWidget {
  const TODOPAGE({super.key});

  @override
  State<TODOPAGE> createState() => _TODOPAGEState();
}

class _TODOPAGEState extends State<TODOPAGE> {
  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ROBBIE\'S PLANNER'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: goalProvider.myTaskTitle.length,
        itemBuilder: (context, index) => TODOVIEW(
          title: goalProvider.myTaskTitle[index],
          description: goalProvider.myTaskDescription[index],
          deadline: DateTime.now(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          openDialog();
        },
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
