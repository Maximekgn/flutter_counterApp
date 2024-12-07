import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'COUNTER APP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("You clicked the button $_counter times"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _floatingLeftActionButton(),
          _floatingResetActionButton(),
          _floatingRightActionButton(),
        ],
      ),
    );
  }

  // Floating action buttons
  Widget _floatingLeftActionButton() {
    return FloatingActionButton(
      onPressed: () => decrementCounter(),
      child: const Icon(Icons.remove),
    );
  }

  Widget _floatingResetActionButton() {
    return FloatingActionButton(
      onPressed: () => resetCounter(),
      child: const Icon(Icons.refresh),
    );
  }

  Widget _floatingRightActionButton() {
    return FloatingActionButton(
      onPressed: () => incrementCounter(),
      backgroundColor: Colors.blue,
      child: const Icon(Icons.add),
    );
  }

  // Counter methods
  void incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void resetCounter() {
    setState(() {
      _counter = 0;
    });
  }
}
