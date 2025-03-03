import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:myfirst_app/sec_screen.dart';

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
  TextEditingController nameTextF = TextEditingController();
  GlobalKey<FormState> myForm = GlobalKey<FormState>();
  setMyName() {
    if (myForm.currentState!.validate()) {
      name = "My Name is: ${nameTextF.text}";
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MySecScreen(name: name)),
      );
    } else {
      print("Not Valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: 500,
        height: 300,
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Form(
              key: myForm,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameTextF,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Please Enter Your Name";
                      }
                      if (text.length < 3) {
                        return "The Name must be more then 3 letters";
                      }
                    },

                    decoration: InputDecoration(label: Text("Enter Your Name")),
                  ),
                ],
              ),
            ),

            Text(
              name,
              style: ArabicTextStyle(
                arabicFont: ArabicFont.lemonada,
                fontSize: 30,
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setMyName();

                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (_) => MySecScreen()),
                // );
              },
              child: Text("My Button"),
            ),
          ],
        ),
      ),
    );
  }
}
