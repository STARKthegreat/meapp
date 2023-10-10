import 'package:flutter/material.dart';
import 'package:meapp/const/app_assets.dart';

class HomeWelcomeWidget extends StatelessWidget {
  const HomeWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(8),
      width: 300,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Greeting and Image Section
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Vipi Robbie 👋"),
              CircleAvatar(
                radius: 20,
                child: Image.asset(AppAssets.logo),
              ),
            ],
          ),
          //Quote Section
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's Quote"),
              Text(
                "I AM A WARRIOR,\nI NEVER GIVE UP,\nI AM BLESSED BECAUSE\nI GOT FIGHT",
              )
            ],
          ),
        ],
      ),
    );
  }
}
