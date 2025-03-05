import 'package:flutter/material.dart';
import 'package:myfirst_app/login_screen.dart';
import 'package:myfirst_app/main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  signup() async {
    setState(() {
      isLoading = true;
    });
    try {
      await supabase.auth.signUp(
        password: passwordController.text,
        email: emailController.text,
        data: {"name": "Omar", "phone": "91234567"},
      );
      await showDialog(
        context: context,
        builder: (co) {
          return Dialog(child: Text("Welcome to the app"));
        },
      );
      await supabase.auth.signOut();
    } catch (e) {
      print(e);
      await showDialog(
        context: context,
        builder: (co) {
          return Dialog(child: Text("Oops something went wrong"));
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
      appBar: AppBar(title: Text("Signup")),
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
                obscureText: true,
                onTap: () {},
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
              ),

              isLoading
                  ? CircularProgressIndicator()
                  : TextButton(
                    onPressed: () {
                      signup();
                    },
                    child: Text("Signup", style: TextStyle(fontSize: 30)),
                  ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },

                child: Text("You have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
