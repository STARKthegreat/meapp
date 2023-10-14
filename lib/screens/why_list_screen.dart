import 'package:flutter/material.dart';
import 'package:meapp/view_model/why_list_model.dart';
import 'package:meapp/widgets/why_list_view_widget.dart';
import 'package:provider/provider.dart';

class WhyListScreen extends StatefulWidget {
  const WhyListScreen({super.key});

  @override
  State<WhyListScreen> createState() => _WhyListScreenState();
}

class _WhyListScreenState extends State<WhyListScreen> {
  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<WhyListViewModel>(context);

    goalProvider.getWhyList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ROBBIE\'S PLANNER'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: goalProvider.whyList.length,
          itemBuilder: (context, index) {
            return WhyListViewWidget(
              title: goalProvider.whyList[index].title,
              description: goalProvider.whyList[index].description,
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

  TextEditingController goalTitleController = TextEditingController();
  TextEditingController goalDescriptionController = TextEditingController();
  openDialog() => showDialog(
        context: context,
        builder: (context) {
          final goalProvider = Provider.of<WhyListViewModel>(context);
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
              ],
            ),
            actions: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        //Add a goal
                        goalProvider
                            .addAndSaveToWhyList(
                              description: goalDescriptionController.text,
                              title: goalTitleController.text,
                            )
                            .whenComplete(
                              () => Navigator.pop(context),
                            );
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
