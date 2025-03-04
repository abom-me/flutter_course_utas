import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  login() async {
    Map myData = {
      "username": emailController.text,
      "password": passwordController.text,
    };

    var res = await api.post(
      Uri.parse("https://dummyjson.com/auth/login"),
      body: myData,
    );

    if (res.statusCode == 200) {
      print("Login Success");
      print(res.body);
      SharedPreferences myStorage = await SharedPreferences.getInstance();
      Map data = jsonDecode(res.body);
      myStorage.setString("token", data["accessToken"]);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Welcome ${data["firstName"]}")));
    } else {
      showDialog(
        context: context,
        builder: (cnx) {
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text("Invalid Email or Password"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onTap: () {
                  emailController.text = 'emilys';
                  setState(() {});
                },
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),

              TextFormField(
                onTap: () {
                  passwordController.text = 'emilyspass';
                  setState(() {});
                },
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
              ),

              TextButton(
                onPressed: () {
                  login();
                },
                child: Text("Login", style: TextStyle(fontSize: 30)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
