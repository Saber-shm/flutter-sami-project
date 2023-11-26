import 'dart:convert';
import 'dart:core';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:frontend/pages/login/admin/details/voir_images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login/admin/ajouter/ajouter_une_remarque.dart';
import 'package:frontend/pages/login/admin/details/voir_remarque.dart';
import 'package:frontend/pages/login/admin/home.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

import '../../../edit_ordre.dart';
import '../admin/ajouter/ajouter_sav.dart';

class Tech_details_page extends StatefulWidget {
  final id;
  Tech_details_page({super.key, this.id});

  @override
  State<Tech_details_page> createState() => Tech_details_pageState();
}

class Tech_details_pageState extends State<Tech_details_page> {
  late Map dataList = {};
  late SharedPreferences prefs;
  late Map svresponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveNotes();
    initSharePref();
  }

  void initSharePref() async {
    prefs = await SharedPreferences.getInstance();
  }

  retrieveNotes() async {
    var response = await http.get(
        Uri.parse('https://sirinelec.be/api/GetOrderDetails/${widget.id}'));
    if (response.statusCode == 200) {
      dataList = json.decode(response.body); // Parse JSON here
      dataList.remove("deleted");
      var respone2 = await http
          .get(Uri.parse("https://sirinelec.be/api/checksav/${widget.id}"));
      svresponse = json.decode(respone2.body);
    } else {
      print('failed');
    }
  }

  suprimmer() async {
    var response = await http
        .get(Uri.parse('https://sirinelec.be//api/Delete_ordre/${widget.id}'));
  }

  Future<void> sendImageToServer(int ordreId) async {
    final token = prefs.getString('refresh');
    Map<String, dynamic> jwtdecoder = JwtDecoder.decode(token!);
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final Map<String, dynamic> requestData = {
        "pic": base64Image, // Use the actual base64-encoded image data
        "ordre": widget.id,
        "posted_by": jwtdecoder["user_id"].toString()
      };
      print(jwtdecoder["user_id"].toString());

      final response = await http.post(
        Uri.parse('https://sirinelec.be/api/UploadPic/$ordreId'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed with status code: ${response.statusCode}');
        // Handle other status codes (e.g., 400, 500) here
      }
    } else {
      print('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Information de l'ordre:"),
          backgroundColor: Colors.green,
        ),
        floatingActionButton: FutureBuilder<void>(
            future: retrieveNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While data is loading, you can display a loading indicator.
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If an error occurs, you can display an error message.
                return Text('Error: ${snapshot.error}');
              } else {
                // Data has been successfully loaded, you can display it here.
                return SpeedDial(
                    icon: Icons.edit,
                    backgroundColor: Colors.green,
                    children: [
                      SpeedDialChild(
                        child: const Icon(Icons.arrow_circle_down_rounded,
                            color: Colors.white),
                        label: 'Telecharger fiche de projet',
                        backgroundColor: Colors.green,
                        onTap: () async {
                          var url =
                              'https://sirinelec.be/admin_app/generate_pdf/${widget.id}'; // Replace with your desired URL
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                      SpeedDialChild(
                        child: const Icon(Icons.remove_red_eye,
                            color: Colors.white),
                        label: 'Remarques',
                        backgroundColor: Colors.green,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Admin_Remarque(
                                        ordre_id: dataList["id"],
                                      )));
                        },
                      ),

                      // if (dataList["deleted"] == false)
                      SpeedDialChild(
                        child: const Icon(Icons.remove_red_eye,
                            color: Colors.white),
                        label: 'Photos',
                        backgroundColor: Colors.green,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VoirPhotos(
                                        ordre_id: dataList["id"],
                                      )));
                        },
                      ),
                      SpeedDialChild(
                        child:
                            const Icon(Icons.add_a_photo, color: Colors.white),
                        label: 'Ajouter photos',
                        backgroundColor: Colors.green,
                        onTap: () {
                          sendImageToServer(widget.id);
                        },
                      ),
                      SpeedDialChild(
                        child: const Icon(Icons.add, color: Colors.white),
                        label: 'Ajouter remarque',
                        backgroundColor: Colors.green,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AjouterRemarque(
                                        ordre_id: dataList["id"],
                                      )));
                        },
                      ),

                      SpeedDialChild(
                        child: Icon(
                            (svresponse["num"] == "none")
                                ? Icons.add
                                : Icons.download,
                            color: Colors.white),
                        label: (svresponse["num"] == "none")
                            ? 'Ajouter SAV'
                            : "Telecharger SAV",
                        backgroundColor: Colors.green,
                        onTap: (svresponse["num"] == "none")
                            ? () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AjouterSav(
                                              id: dataList["id"],
                                            )));
                              }
                            : () async {
                                var url =
                                    'https://sirinelec.be/admin_app/generate_sav/${widget.id}'; // Replace with your desired URL
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                      ),
                      SpeedDialChild(
                        child: const Icon(Icons.edit, color: Colors.white),
                        label: 'Modifier',
                        backgroundColor: Colors.green,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Modifier(id: widget.id)));
                        },
                      )
                    ]);
              }
            }),
        body: FutureBuilder<void>(
          future: retrieveNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading, you can display a loading indicator.
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If an error occurs, you can display an error message.
              return Text('Error: ${snapshot.error}');
            } else {
              // Data has been successfully loaded, you can display it here.
              return Column(children: [
                // ElevatedButton(onPressed: () {}, child: Text("Modifier")),
                // ElevatedButton(
                //     onPressed: () async {}, child: Text("Ajouter Photo")),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => AjouterRemarque(
                //                     ordre_id: widget.id,
                //                   )));
                //     },
                //     child: Text("Ajouter remarque")),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   Admin_Remarque(ordre_id: widget.id)));
                //     },
                //     child: Text("Remarque")),
                // ElevatedButton(onPressed: () {}, child: Text("Photos")),
                // ElevatedButton(
                //     onPressed: () {
                //       final result = showDialog(
                //         context: context,
                //         builder: (_) => AlertDialog(
                //           title: Text("Warning"),
                //           content: Text(
                //               "Êtes-vous sûr de vouloir supprimer cette ordre?"),
                //           actions: <Widget>[
                //             TextButton(
                //                 onPressed: () {
                //                   suprimmer();
                //                   Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                           builder: (context) =>
                //                               Admin_Home_page()));
                //                 },
                //                 child: Text("Oui")),
                //             TextButton(
                //                 onPressed: () {
                //                   Navigator.of(context).pop(false);
                //                 },
                //                 child: Text("Non")),
                //           ],
                //         ),
                //       );
                //     },
                //     child: Text("Suprimmer")),
                // ElevatedButton(
                //     onPressed: () {
                //       var url = Uri.parse('https://google.com');
                //       launchUrl("" as Uri);
                //       // launchUrl("google.com" as Uri);
                //     },
                //     child: Text("Telecharger fiche de project")),
                Expanded(
                    child: ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          final key = dataList.keys.elementAt(index);
                          final value = dataList[key];

                          return ListTile(
                            title: Text(key),
                            subtitle: Text(value?.toString() ?? 'Case vide'),
                          );
                        }))
              ]); // Replace with your widget
            }
          },
        )

        // Column(children: [
        //   ElevatedButton(
        //       onPressed: () {
        //         print(dataList);
        //       },
        //       child: Text("test")),
        // ListView.builder(
        //     itemCount: dataList.length,
        //     itemBuilder: (context, index) {
        //       final key = dataList.keys.elementAt(index);
        //       final value = dataList[key];

        //       return ListTile(
        //         title: Text(key),
        //         subtitle: Text(value?.toString() ?? 'Case vide'),
        //       );
        //     })
        // ])
        //  Column(
        // children: [
        //   Text(""),
        //   Text(""),
        //   SizedBox(
        //       width: 350.0,
        //       height: 70.0,
        //       child: ElevatedButton(
        //         child: Text("Modifier"),
        //         onPressed: () {
        //           print("pressed");
        //         },
        //       )),
        //   Text(""),
        //   Text(""),
        //   SizedBox(
        //       width: 350.0,
        //       height: 70.0,
        //       child: ElevatedButton(
        //         child: Text("Ajouter Remarque"),
        //         onPressed: () {
        //           print("pressed");
        //         },
        //       )),
        //   Text(""),
        //   Text(""),
        //   SizedBox(
        //       width: 350.0,
        //       height: 70.0,
        //       child: ElevatedButton(
        //         child: Text("Ajouter Photo"),
        //         onPressed: () {
        //           print("pressed");
        //         },
        //       )),
        //   Text(""),
        //   Text(""),
        //   SizedBox(
        //       width: 350.0,
        //       height: 70.0,
        //       child: ElevatedButton(
        //         child: Text("Ajouter SAV"),
        //         onPressed: () {
        //           print("pressed");
        //         },
        //       )),
        //   Text(""),
        //   Text(""),
        //   SizedBox(
        //       width: 350.0,
        //       height: 70.0,
        //       child: ElevatedButton(
        //         child: Text("Remarques"),
        //         onPressed: () {
        //           print("pressed");
        //         },
        //       )),
        //   Text(""),
        //   Text(""),
        //   SizedBox(
        //       width: 350.0,
        //       height: 70.0,
        //       child: ElevatedButton(
        //         child: Text("Photos"),
        //         onPressed: () {
        //           print("pressed");
        //         },
        //       )),
        //   Text(""),
        //   Text(""),
        //   SizedBox(
        //       width: 350.0,
        //       height: 70.0,
        //       child: ElevatedButton(
        //         child: Text("Modifier"),
        //         onPressed: () {
        //           print("pressed");
        //         },
        //       )),
        // ],

        // )

        );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl("google.com" as Uri)) {
    throw Exception('Could not launch ');
  }
}
