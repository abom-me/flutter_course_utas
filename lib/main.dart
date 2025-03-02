import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffffb0ff)),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "Click the btn to see my name";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),

      body: Container(
        width: 500,
        height: 300,
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(name, style: TextStyle(fontSize: 20)),

            ElevatedButton(
              onPressed: () {
                name = "My Name is: Omar";
                setState(() {});
              },
              child: Text("My Button"),
            ),
          ],
        ),
      ),
    );
  }
}
