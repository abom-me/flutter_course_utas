import 'package:flutter/material.dart';
import 'package:myfirst_app/main.dart';

class MyData extends StatefulWidget {
  const MyData({super.key});

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  Map<String, dynamic> myDataMap = {};
  getMyData() async {
    final email = supabase.auth.currentUser?.email ?? "";
    final myData = await supabase.from("users").select().eq("email", email);
    if (myData.isNotEmpty) {
      setState(() {
        myDataMap = myData[0];
      });
    } else {
      print("No data found");
    }
  }

  @override
  void initState() {
    getMyData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 500,

      width: MediaQuery.sizeOf(context).width,

      child:
          myDataMap.isEmpty
              ? CircularProgressIndicator()
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("UserName: ${myDataMap["username"]}"),
                  Text("Full Name: ${myDataMap["full_name"]}"),
                  Text("Email: ${myDataMap["email"]}"),
                ],
              ),
    );
  }
}
