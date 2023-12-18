import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meapp/const/app_assets.dart';
import 'package:meapp/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeWelcomeWidget extends StatelessWidget {
  const HomeWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeViewModel>(context);
    showEditDialog() => showDialog(
          context: context,
          builder: (context) {
            TextEditingController sloganTextController = TextEditingController(
                text: homeProvider.sloganList.last.isEmpty
                    ? "New Slogan"
                    : homeProvider.sloganList.last);
            return AlertDialog(
              title: const Text("Save your Slogan"),
              content: TextFormField(
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Slogan",
                ),
                controller: sloganTextController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      log(homeProvider.sloganList.length.toString());
                      // for (String s in homeProvider.sloganList) {
                      //   if (s == sloganTextController.text) {
                      homeProvider.editSlogan(
                          homeProvider.sloganList
                              .indexOf(homeProvider.sloganList.last),
                          sloganTextController.text);
                      // }
                      // }
                    },
                    child: const Text("Edit")),
                ElevatedButton(
                  onPressed: () {
                    if (sloganTextController.text.isNotEmpty) {
                      homeProvider.addSlogan(sloganTextController.text);
                    }
                  },
                  child: const Text("Save"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Greeting and Image Section
          const Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Today's Quote"),
                  IconButton(
                    onPressed: () {
                      showEditDialog();
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
              Consumer<HomeViewModel>(
                builder: (context, homeProvider, child) {
                  if (homeProvider.sloganList.isNotEmpty) {
                    return Text(
                      homeProvider.sloganList.last.toUpperCase(),
                      overflow: TextOverflow.clip,
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
