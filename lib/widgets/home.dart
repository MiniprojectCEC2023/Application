import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../connections/mongoconn.dart';
import '../main.dart';
import 'Office.dart';
import 'library.dart';
import '../global/globals.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Color(0xFF142D34),
        elevation: 20,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(
                    Icons.qr_code_2,
                    color: Colors.white,
                  ),
                  title: Text(
                    'QR Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context); // Close the popup menu
                    final qrCodesCollection =
                        MongoUtils.db.collection('student');
                    var qrCode = await qrCodesCollection.findOne(
                      {'register_number': registerNumber},
                    );

                    if (qrCode != null) {
                      final qrCodeBytes =
                          Uint8List.fromList(qrCode['qr_code'].byteList);
                      var qrCodeImage = Image.memory(qrCodeBytes);

                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: qrCodeImage,
                        ),
                      );
                    }
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    // Close the popup menu
                    // Perform logout logic here
                  },
                ),
              ),
            ],
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            elevation: 20,
            offset: Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Color(0xFF142D34),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome $name!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF142D34),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Library",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Please click the below button to view library details",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IntrinsicWidth(
                          child: TextButton(
                            onPressed: () async {
                              var libraryCollection =
                                  MongoUtils.db.collection('library');
                              var libraryDetails = await libraryCollection.findOne(
                                  {'register_number': registerNumber});

                              if (libraryDetails != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Library(details: libraryDetails),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Profile Not Found'),
                                    content: Text(
                                      'No library profile found for $name.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "View Profile",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF4CA6AF)
,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "College Bus",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Please click the below button to view college bus details",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IntrinsicWidth(
                          child: TextButton(
                            onPressed: () async {
                              var busCollection =
                                  MongoUtils.db.collection('bus');
                              var busDetails = await busCollection.findOne(
                                  {'register_number': registerNumber});

                              if (busDetails != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Office(details: busDetails),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Profile Not Found'),
                                    content: Text(
                                      'No college bus profile found for $name.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "View Profile",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF4CA6AF)
,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
