import 'package:flutter/material.dart';

class MobileMoreTabWidget extends StatelessWidget {
  const MobileMoreTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.all(size.width * 0.06),
      width: size.width * 0.2,
      height: size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.add),
        ],
      ),
    );
  }
}
