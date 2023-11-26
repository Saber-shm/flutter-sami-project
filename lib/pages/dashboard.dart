import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DashBoard extends StatefulWidget {
  final token;
  const DashBoard({@required this.token, Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late var username;
  late var usernamee;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtdecoder = JwtDecoder.decode(widget.token);
    usernamee = jwtdecoder.toString();
    print(jwtdecoder["user_id"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [Text(usernamee), Text("hello")],
    )));
  }
}
