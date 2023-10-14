import 'package:flutter/material.dart';

class WhyListViewWidget extends StatefulWidget {
  final String title;
  final String description;

  const WhyListViewWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<WhyListViewWidget> createState() => _WhyListViewWidgetState();
}

class _WhyListViewWidgetState extends State<WhyListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Text(""),
      iconColor: Colors.black,
      textColor: Colors.black,
      title: Text(widget.title),
      subtitle: Text(widget.description),
    );
  }
}
