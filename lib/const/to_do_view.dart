import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meapp/screens/goals_screen/to_do_description.dart';

class TODOVIEW extends StatefulWidget {
  final String title;
  final String description;
  final DateTime deadline;
  const TODOVIEW(
      {super.key,
      required this.title,
      required this.description,
      required this.deadline});

  @override
  State<TODOVIEW> createState() => _TODOVIEWState();
}

class _TODOVIEWState extends State<TODOVIEW> {
  bool _checked = false;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      trailing: Text(widget.deadline.toString()),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TodoDescription(description: widget.description),
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
                    onPressed: () async {
                      final XFile? photoGallery =
                          await _picker.pickImage(source: ImageSource.gallery);
                      final XFile? cameraImage =
                          await _picker.pickImage(source: ImageSource.camera);
                    },
                    child: const Text('Upload')),
                ElevatedButton(
                  onPressed: () {
                    return;
                  },
                  child: const Text('I lied'),
                )
              ],
            ),
          ),
        ),
      );
}
