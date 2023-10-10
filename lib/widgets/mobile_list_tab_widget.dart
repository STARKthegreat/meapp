import 'package:flutter/material.dart';

class MobileListTabWidget extends StatelessWidget {
  final String listTabTitle;
  const MobileListTabWidget({super.key, required this.listTabTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 80,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.menu),
            Text(listTabTitle),
          ],
        ),
      ),
    );
  }
}
