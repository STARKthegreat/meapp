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
  DateTime deadline = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<TaskProvider>(context);
    goalProvider.fetchTask();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ROBBIE\'S PLANNER'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: goalProvider.myGoals.length,
          itemBuilder: (context, index) {
            return TODOVIEW(
              title: goalProvider.myGoals[index].title,
              description: goalProvider.myGoals[index].description,
              deadline: goalProvider.myGoals[index].deadline,
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          openDialog();
        },
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());
  openDialog() => showDialog(
        context: context,
        builder: (context) {
          final goalProvider = Provider.of<TaskProvider>(context);
          TextEditingController goalTitleController = TextEditingController();
          TextEditingController goalDescriptionController =
              TextEditingController();
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
                Text(
                    '${deadline.year}/${deadline.month}/${deadline.day}   ${deadline.hour}:${deadline.minute}'),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? date = await pickDate();
                    if (date == null) return;
                    TimeOfDay? time = await pickTime();
                    if (time == null) return;

                    final deadline = DateTime(date.year, date.month, date.day,
                        time.hour, time.minute);
                    setState(() {
                      this.deadline = deadline;
                    });
                  },
                  child: const Text('Pick a Deadline'),
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        //Add a goal
                        goalProvider.storeGoals(
                            description: goalDescriptionController.text.trim(),
                            title: goalTitleController.text.trim(),
                            deadline: deadline);
                        //CLOSE AFTER
                        Navigator.pop(context);
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
