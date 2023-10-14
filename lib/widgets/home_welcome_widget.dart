import 'package:flutter/material.dart';
import 'package:meapp/const/app_assets.dart';

class HomeWelcomeWidget extends StatelessWidget {
  const HomeWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(8),
      width: size.width,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Greeting and Image Section
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Vipi Robbie 👋"),
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(AppAssets.logo),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(50),
                //   child: Image.asset(
                //     AppAssets.logo,
                //     fit: BoxFit.cover,
                //   ),
                // ),
              ),
            ],
          ),
          //Quote Section
          Column(
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
