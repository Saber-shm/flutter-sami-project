import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login/admin/home.dart';
import 'package:frontend/pages/login/com/home.dart';
import 'package:frontend/pages/login/login.dart';
import 'package:frontend/pages/login/tech/tech_home_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class Check_in_page extends StatefulWidget {
  final token;
  Check_in_page({super.key, this.token});

  @override
  State<Check_in_page> createState() => _Check_in_pageState();
}

class _Check_in_pageState extends State<Check_in_page> {
  verify_user() async {
    var token = widget.token;
    var isTokenValid = token != null && !JwtDecoder.isExpired(token!);

    if (isTokenValid) {
      print("yess");
      Map<String, dynamic> jwtdecoder = JwtDecoder.decode(token!);
      var response = await http.get(Uri.parse(
          'https://sirinelec.be/api/GetAccType/${jwtdecoder['user_id']}'));
      var response_data = json.decode(response.body);
      if (response_data["Type"] == "Admin") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Admin_Home_page()));
      } else if (response_data["Type"] == "com") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Com_home_page()));
      } else if (response_data["Type"] == "tech") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TechHomePage()));
      }
    } else {
      print("no");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => LoginDemo(),
        ));
      });
    }
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => LoginDemo()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verify_user();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CircularProgressIndicator());
  }
}
