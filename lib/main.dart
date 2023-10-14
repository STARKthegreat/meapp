import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meapp/models/goal_storage.dart';
import 'package:meapp/models/why_list_adapter.dart';
import 'package:meapp/screens/home_screen.dart';
import 'package:meapp/style/app_colors.dart';
import 'package:meapp/view_model/to_do_model.dart';
import 'package:meapp/view_model/why_list_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //initialize widget before run app
  await Hive.initFlutter();
  Hive.registerAdapter(GoalStorageAdapter());
  Hive.registerAdapter(WhyListAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => WhyListViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Me App: Productivity Tool',
      theme: ThemeData(
        textTheme: const TextTheme(
            displayMedium: TextStyle(overflow: TextOverflow.clip)),
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primaryColor,
      ),
      home: const HomeScreen(),
    );
  }
}
