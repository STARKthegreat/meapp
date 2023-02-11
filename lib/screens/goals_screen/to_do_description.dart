import 'package:flutter/material.dart';
import 'package:meapp/const/to_do_view.dart';
import 'package:meapp/view_model/to_do_model.dart';
import 'package:provider/provider.dart';

class TodoDescription extends StatefulWidget {
  final String title;
  final String description;
  final DateTime deadline;
  const TodoDescription(
      {super.key,
      required this.description,
      required this.title,
      required this.deadline});

  @override
  State<TodoDescription> createState() => _TodoDescriptionState();
}

class _TodoDescriptionState extends State<TodoDescription> {
  DateTime subDeadline = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<TaskProvider>(context);
    goalProvider.storeLinkedGoal();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Description:'), //title fomart
          Text(widget.description),
          Text('Deadline: ${DateTime.now().difference(widget.deadline)}'),
          const Text('Subtasks:'), //Title format
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: goalProvider.mySubGoals.length,
              itemBuilder: (context, index) => TODOVIEW(
                  title: goalProvider.linkedgoal
                      .elementAt(index)
                      .subgoals[index]
                      .title,
                  description: goalProvider.mySubGoals[index].description,
                  deadline: goalProvider.mySubGoals[index].deadline),
            ),
          ),
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

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  TextEditingController subGoalTitleController = TextEditingController();
  TextEditingController subGoalDescriptionController = TextEditingController();
  Future<TimeOfDay?> pickTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());
  openDialog() => showDialog(
        context: context,
        builder: (context) {
          final goalProvider = Provider.of<TaskProvider>(context);
          //goalProvider.mySubGoals.clear();
          return AlertDialog(
            title: const Text('ADD goal'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: subGoalTitleController,
                  decoration: const InputDecoration(
                    hintText: 'goal Title',
                  ),
                ),
                TextFormField(
                  controller: subGoalDescriptionController,
                  decoration: const InputDecoration(
                    hintText: 'goal Description',
                  ),
                ),
                Text(
                    '${subDeadline.year}/${subDeadline.month}/${subDeadline.day}   ${subDeadline.hour}:${subDeadline.minute}'),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? date = await pickDate();
                    if (date == null) return;
                    TimeOfDay? time = await pickTime();
                    if (time == null) return;

                    final deadline = DateTime(date.year, date.month, date.day,
                        time.hour, time.minute);
                    setState(() {
                      subDeadline = deadline;
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
                        goalProvider.storeSubGoals(
                            description:
                                subGoalDescriptionController.text.trim(),
                            title: subGoalTitleController.text.trim(),
                            deadline: subDeadline);
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
