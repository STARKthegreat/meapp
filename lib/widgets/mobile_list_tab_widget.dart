import 'package:flutter/material.dart';

class MobileListTabWidget extends StatelessWidget {
  final String listTabTitle;
  final void Function() onPressed;
  const MobileListTabWidget(
      {super.key, required this.listTabTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: EdgeInsets.all(size.width * 0.06),
        width: size.width * 0.2,
        height: size.height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.menu),
            const Spacer(),
            Text(
              listTabTitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
