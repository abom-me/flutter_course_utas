import 'package:flutter/material.dart';
import 'package:myfirst_app/main.dart';
import 'package:myfirst_app/userdata.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    emailController.text = supabase.auth.currentUser?.email ?? "Unknown";
    super.initState();
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  save() async {
    setState(() {
      isLoading = true;
    });
    try {
      await supabase.from("users").insert({
        "username": usernameController.text,
        "full_name": fullNameController.text,
        "email": emailController.text,
      });
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Profile created successfully"),
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text("Error"), content: Text(e.toString()));
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
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),

          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return MyData();
                },
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: "Full Name"),
            ),
            TextFormField(
              readOnly: true,
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            isLoading
                ? CircularProgressIndicator()
                : TextButton(
                  onPressed: () {
                    save();
                  },
                  child: Text("create profile"),
                ),
          ],
        ),
      ),
    );
  }
}
