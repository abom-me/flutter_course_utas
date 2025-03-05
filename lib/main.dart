import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myfirst_app/login_screen.dart';
import 'package:myfirst_app/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://tvuovkhrwxlrqmduspay.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR2dW92a2hyd3hscnFtZHVzcGF5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDExNzgyNTMsImV4cCI6MjA1Njc1NDI1M30.U4fT_K3APmoXm2c0Zj8fYy7-opXH5d4TioUHqHuu4xo",
  );
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
              final user = supabase.auth.currentUser;
              if (user?.email != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
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
