// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/check_in_page.dart';
import 'package:frontend/dateflied_test.dart';
import 'package:frontend/open_link_test.dart';
import 'package:frontend/pages/dashboard.dart';
import 'package:frontend/pages/login/admin/home.dart';
import 'package:frontend/pages/login/com/home.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:frontend/pages/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('refresh');
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token; // Make the token nullable

  const MyApp({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the token is null or expired
    final isTokenValid = token != null && !JwtDecoder.isExpired(token!);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sirinelec',
        theme: ThemeData(
          primarySwatch: Colors.green, // Set the primary color to green
          // drawerTheme: DrawerThemeData(),
        ),
        // home: Open_link_test()
        home:
            //  SENDDATETEST());
            Scaffold(
                // DashBoard(token: token)
                body: Check_in_page(
          token: token,
        )
                // /Com_home_pag  e()

                // isTokenValid ? Admin_Home_page() : LoginDemo(),
                // )
                ));
  }
}
