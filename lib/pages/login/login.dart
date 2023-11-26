import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/check_in_page.dart';
import 'package:frontend/pages/dashboard.dart';
import 'package:frontend/pages/login/admin/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharePref();
  }

  void initSharePref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    print(prefs);
    if (prefs == null) {
      return;
    }
    if (controller1.text.isNotEmpty && controller2.text.isNotEmpty) {
      var regbody = {
        "username": controller1.text,
        "password": controller2.text,
      };
      var response = await http.post(
          Uri.parse("http://sirinelec.be/api/token/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
      print(response);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (jsonResponse.containsKey("access")) {
        var token = jsonResponse["access"];
        print(token);
        prefs.setString("refresh", token);
        // Navigator.pop(context, );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Check_in_page(
                      token: token,
                    )));
      } else {
        print("Somthing went wrong");
      }
    }
  }

  void test() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("refresh"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Page"),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            loginUser();
          },
          label: Text("Se connecter"),
          icon: Icon(Icons.login)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 200, bottom: 0),
              //  EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                // initialValue: "2000-1-1",

                controller: controller1,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: "Nom d'utilisateur: ",
                  label: Text("Nom d'utilisateur"),
                  // hintStyle: TextStyle(color: Colors), // Hint text color
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.green), // Focused border color
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 40, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                // initialValue: "2000-1-1",

                controller: controller2,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  label: Text("Mot de passe"),
                  // hintStyle: TextStyle(color: Colors), // Hint text color
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.green), // Focused border color
                  ),
                ),
              ),
            ),
            // TextField(
            //   controller: controller2,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: 'Password',
            //     labelStyle: TextStyle(color: Colors.green),
            //     hintText: 'Entrer le mot de passe',
            //     // hintStyle: TextStyle(color: Colors.green),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide:
            //           BorderSide(color: Colors.green), // Focused border color
            //     ),
            //   ),
            // ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 15.0, right: 15.0, top: 100, bottom: 0),
            //   child: Container(
            //     height: 50,
            //     width: 250,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         loginUser();
            //       },
            //       style: ButtonStyle(
            //         backgroundColor:
            //             MaterialStateProperty.all<Color>(Colors.green),
            //       ),
            //       child: Text(
            //         'Login',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 25,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
