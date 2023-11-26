import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class VoirPhotos extends StatefulWidget {
  final ordre_id;
  const VoirPhotos({super.key, this.ordre_id});

  @override
  State<VoirPhotos> createState() => _VoirPhotosState();
}

class _VoirPhotosState extends State<VoirPhotos> {
  late List<dynamic> dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrievePics();
  }

  retrievePics() async {
    var response = await http
        .get(Uri.parse('https://sirinelec.be/api/GetPic/${widget.ordre_id}'));

    if (response.statusCode == 200) {
      dataList = json.decode(response.body); // Parse JSON here
      print(dataList);
      print('bravo');
    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
          future: retrievePics(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://sirinelec.be/${dataList[index]['pic']}",
                      width: 200, // Adjust the width to make the image bigger
                      height: 400,
                    ),
                    Text(
                      "Posté par ${dataList[index]["posted_by_username"]} en ${dataList[index]["post_date"]}",
                      style: TextStyle(
                          fontSize: 16), // Adjust the font size as needed
                    ),
                    SizedBox(
                        height:
                            30), // Optional spacing between the image and date
                  ],
                );
              },
            );
          }),
    );
  }
}
