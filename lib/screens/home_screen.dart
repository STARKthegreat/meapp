import 'package:flutter/material.dart';
import 'package:meapp/style/app_colors.dart';
import 'package:meapp/widgets/home_welcome_widget.dart';
import 'package:meapp/widgets/mobile_list_tab_widget.dart';
import 'package:meapp/widgets/mobile_more_tab_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _mobileTabTitle = ["To Do List", "My Why"];

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowChildrenTabs = List.generate(
      _mobileTabTitle.length,
      (index) => MobileListTabWidget(
        listTabTitle: _mobileTabTitle[index],
      ),
      growable: true,
    );
    if (_mobileTabTitle.length % 3 != 0) {
      rowChildrenTabs.add(const MobileMoreTabWidget());
    }
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Robbie App",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HomeWelcomeWidget(),
            Row(
              children: rowChildrenTabs,
            )
          ],
        ),
      ),
    );
  }
}
