import 'package:flutter/material.dart';

class MySecScreen extends StatefulWidget {
  const MySecScreen({super.key, required this.name});
  final String name;

  @override
  State<MySecScreen> createState() => _MySecScreenState();
}

class _MySecScreenState extends State<MySecScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sec Screen")),

      body: Column(
        spacing: 50,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("img/pn.jpeg", width: 600, height: 300),
          Image.network(
            "https://icon2.cleanpng.com/lnd/20250302/lk/e4f27d12b6157bfb5775ee13682d47.webp",
            width: 600,
            height: 300,
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => MyThirdScreen()),
              // );
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (_) => MyThirdScreen()),
              // );
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (_) => MyThirdScreen()),
              //   (route) => false,
              // );
            },
            child: Text("Go to Third Screen"),
          ),
        ],
      ),
    );
  }
}
