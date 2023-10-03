import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //------------------------------------------------------------
  User? user = FirebaseAuth.instance.currentUser; //1ST STEP
  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child("/EPVvCNLNRpOv5msHYforhcO6wYW2/");
  //------------------------------------------------------------

  String data1 = "";
  int data2 = 0;
  bool data3 = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final map = snapshot.data?.snapshot.value as Map;
          String test = map["data1"];
          int test1 = map["data2"];
          bool test2 = map["data3"];

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    test,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    "$test1",
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    "$test2",
                    style: TextStyle(fontSize: 30),
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseDatabase.instance.ref().child(user!.uid).set({
                        'data1': "My name is Harris", // String
                        'data2': 1999, // double
                        'data3': false, // bool
                        'data4': "NEW DATA"
                      });
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "Create",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: Colors.blue,
                      height: 50,
                      width: 120,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      child: Center(
                        child: Text(
                          "Read",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: Colors.blue,
                      height: 50,
                      width: 120,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseDatabase.instance.ref().child(user!.uid).update({
                        'data1': "MACHINE GUN!!", // String
                      });
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: Colors.blue,
                      height: 50,
                      width: 120,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseDatabase.instance.ref().child(user!.uid).remove();
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: Colors.blue,
                      height: 50,
                      width: 120,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        } else if (!snapshot.hasData) {
          FirebaseDatabase.instance
              .ref()
              .child(user!.uid)
              .set({'data1': data1, 'data2': data2, 'data3': data3});
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
