


import 'package:flutter/material.dart';

class MyThirdScreen extends StatefulWidget {
  const MyThirdScreen({super.key});

  @override
  State<MyThirdScreen> createState() => _MyThirdScreenState();
}

class _MyThirdScreenState extends State<MyThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Third Screen")));
  }
}