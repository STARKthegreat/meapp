import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Make sure this file exists and is correctly configured

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  const MyHomePage({super.key, this.title = 'Todo & Pomodoro App'});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  // Pomodoro Timer
  final int _pomodoroDuration = 25 * 60; // 25 minutes
  final int _shortBreakDuration = 5 * 60; // 5 minutes
  final int _longBreakDuration = 15 * 60; // 15 minutes
  int _currentTime = 25 * 60;
  bool _isRunning = false;
  bool _isBreak = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  initFirebase() async {
    // Suggested code may be subject to a license. Learn more: ~LicenseLog:1688008008.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    _dateController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _addTask() async {
    if (_taskController.text.isNotEmpty && _selectedDate != null) {
      await FirebaseFirestore.instance.collection('tasks').add({
        'task': _taskController.text,
        'deadline': Timestamp.fromDate(_selectedDate!),
        'completed': false,
        'timestamp': Timestamp.now(),
      });
      _taskController.clear();
      _dateController.clear();
      _selectedDate = null;
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _toggleTaskCompletion(DocumentSnapshot task) {
    task.reference.update({'completed': !task['completed']});
  }

  void _deleteTask(DocumentSnapshot task) {
    task.reference.delete();
  }

  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_currentTime > 0) {
            _currentTime--;
          } else {
            _timer?.cancel();
            _isRunning = false;
            _isBreak = !_isBreak;
            _currentTime = _isBreak ? _shortBreakDuration : _pomodoroDuration;
            // You can add notification triggers here for timer completion
          }
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isBreak = false;
      _currentTime = _pomodoroDuration;
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  _formatTime(_currentTime),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isRunning ? _pauseTimer : _startTimer,
                      child: Text(_isRunning ? 'Pause' : 'Start'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _resetTimer,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Tasks',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance
                      .collection('tasks')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tasks = snapshot.data!.docs;

                if (tasks.isEmpty) {
                  return const Center(child: Text('No tasks yet!'));
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Dismissible(
                      key: Key(task.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        _deleteTask(task);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Task deleted')),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text(
                          task['task'],
                          style: TextStyle(
                            decoration:
                                task['completed']
                                    ? TextDecoration.lineThrough
                                    : null,
                          ),
                        ),
                        subtitle: Text(
                          'Deadline: ${_formatDate(task['deadline'].toDate())}',
                        ),
                        trailing: Checkbox(
                          value: task['completed'],
                          onChanged: (value) {
                            _toggleTaskCompletion(task);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _taskController,
                decoration: const InputDecoration(labelText: 'Task'),
              ),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Deadline'),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _taskController.clear();
                _dateController.clear();
                _selectedDate = null;
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(onPressed: _addTask, child: const Text('Add')),
          ],
        );
      },
    );
  }
}
