import 'package:flutter/material.dart';

class MyPracticeScreen extends StatefulWidget {
  const MyPracticeScreen({super.key});

  @override
  State<MyPracticeScreen> createState() => _MyPracticeScreenState();
}

class _MyPracticeScreenState extends State<MyPracticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Practices'),
      ),
      body: Column(
        children: [
          const Text('My Practices'),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return ListTile(
                title: const Text("Practice One"),
                subtitle: const Text("Practice One Description"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PracticeScreen(),
                  ));
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("New Practice"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  List<bool> isCheckedList = List.generate(25, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice One'),
      ),
      body: GridView.count(
        crossAxisCount: 7,
        childAspectRatio: 2 / 3,
        children: List.generate(
          25,
          (index) {
            return Center(
              child: Column(
                children: [
                  Checkbox(
                    value: isCheckedList[index],
                    onChanged: (value) {
                      setState(
                        () {
                          isCheckedList[index] = value!;
                        },
                      );
                    },
                  ),
                  Text('Day ${index + 1}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TextEditingController goalTitleController = TextEditingController();
  TextEditingController goalDescriptionController = TextEditingController();
  openDialog() => showDialog(
        context: context,
        builder: (context) {
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
                const Text(
                  "",
                ),
                ElevatedButton(
                  onPressed: () async {},
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
