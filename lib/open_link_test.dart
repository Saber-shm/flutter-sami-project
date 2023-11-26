import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Open_link_test extends StatelessWidget {
  const Open_link_test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ElevatedButton(
      onPressed: () async {
        const url =
            'https://sirinelec.be/admin_app/generate_pdf/24'; // Replace with your desired URL
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Text('Open Link'),
    )));
  }
}
