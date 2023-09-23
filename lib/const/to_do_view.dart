import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meapp/screens/goals_screen/to_do_description.dart';
import 'package:meapp/view_model/to_do_model.dart';
import 'package:provider/provider.dart';

class TODOVIEW extends StatefulWidget {
  final String title;
  final String description;
  final DateTime deadline;
  final int index;
  const TODOVIEW({
    super.key,
    required this.title,
    required this.description,
    required this.deadline,
    required this.index,
  });

  @override
  State<TODOVIEW> createState() => _TODOVIEWState();
}

class _TODOVIEWState extends State<TODOVIEW> {
  bool _checked = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<TaskProvider>(context);
    return Dismissible(
      key: Key(widget.title),
      onDismissed: (direction) => goalProvider.deleteGoal(index: widget.index),
      child: ListTile(
        iconColor: Colors.black,
        textColor: Colors.black,
        leading: Checkbox(
          onChanged: (newValue) {
            openDialog();
            setState(() {
              _checked = newValue!;
            });
          },
          value: _checked,
        ),
        title: Text(widget.title),
        subtitle: Text(widget.description),
        trailing: Text('${widget.deadline}'),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoDescription(
              title: widget.title,
              description: widget.description,
              deadline: widget.deadline,
              uniqueKey: Key(widget.title),
            ),
          ),
        ),
      ),
    );
  }

  openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Upload an Image as proof'),
          icon: const Icon(Icons.warning),
          content: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: const Text('Upload')),
                ElevatedButton(
                  onPressed: () {
                    return;
                  },
                  child: const Text('I lied'),
                ),
              ],
            ),
          ),
        ),
      );

  void pickImage() async {
    const String image = "ImageBox";
    Box box = await Hive.openBox(image);
    final XFile? photoGallery =
        await _picker.pickImage(source: ImageSource.gallery);
    final XFile? cameraImage =
        await _picker.pickImage(source: ImageSource.camera);
    box.add(photoGallery);
    box.add(cameraImage);
  }
}
