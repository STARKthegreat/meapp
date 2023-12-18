import 'package:flutter/material.dart';
import 'package:meapp/screens/goals_screen/to_do_screen.dart';
import 'package:meapp/screens/why_list_screen.dart';
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
  final TextEditingController _titleTextController =
      TextEditingController(text: "Robbie App");
  @override
  Widget build(BuildContext context) {
    List onPressed = [
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TODOPAGE(),
          ),
        );
      },
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WhyListScreen(),
          ),
        );
      }
    ];
    final List<Widget> rowChildrenTabs = List.generate(
      _mobileTabTitle.length,
      (index) => MobileListTabWidget(
        onPressed: onPressed[index],
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
        title: Text(
          _titleTextController.text,
          style: const TextStyle(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: rowChildrenTabs,
            )
          ],
        ),
      ),
    );
  }
}
