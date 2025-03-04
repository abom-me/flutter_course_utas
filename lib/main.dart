import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myfirst_app/login_screen.dart';
import 'package:myfirst_app/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List todos = [];
  String token = "";
  getTodo() async {
    SharedPreferences myStorage = await SharedPreferences.getInstance();
    token = myStorage.getString("token") ?? "";
    print(token);
    var res = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/todos"),
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      todos = data;
      setState(() {});
    } else {
      print("Oops , we didn't get the data");
    }
  }

  @override
  void initState() {
    getTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),

        actions: [
          IconButton(
            onPressed: () {
              if (token.isEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile()),
                );
              }
            },
            icon: Icon(Icons.lock),
          ),
        ],
      ),

      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              height: 200,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10, top: 5),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red, width: 3),
              ),

              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  children: [
                    Checkbox(
                      value: todos[index]['completed'],

                      onChanged: (status) {
                        todos[index]["completed"] =
                            status != null ? status : true;

                        setState(() {});
                      },
                    ),

                    Text(todos[index]['title']),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
