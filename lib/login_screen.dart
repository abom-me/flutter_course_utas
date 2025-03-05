import 'package:flutter/material.dart';
import 'package:myfirst_app/main.dart';
import 'package:myfirst_app/profile.dart';
import 'package:myfirst_app/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  login() async {
    setState(() {
      isLoading = true;
    });
    try {
      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyProfile()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text("Your email or password is incorrect"),
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
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
                onTap: () {},
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),

              TextFormField(
                onTap: () {},
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
              ),

              isLoading
                  ? CircularProgressIndicator()
                  : TextButton(
                    onPressed: () {
                      login();
                    },
                    child: Text("Login", style: TextStyle(fontSize: 30)),
                  ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },

                child: Text("You dont have an account? Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
