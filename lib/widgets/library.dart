import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../connections/mongoconn.dart';
import '../main.dart';
import 'books.dart';

class Library extends StatefulWidget {
  final Map<String, dynamic> details;

  const Library({Key? key, required this.details}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {

  @override
  Widget build(BuildContext context) {
    String name = widget.details["name"];
    String registerNumber = widget.details["register_number"];
    String semester = widget.details["semester"];
    String branch = widget.details["branch"];
    int maxBook = widget.details["max_book"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Library"),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(name),
                ),
                ListTile(
                  title: Text(
                    "Register Number",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(registerNumber),
                ),
                ListTile(
                  title: Text(
                    "Semester",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(semester),
                ),
                ListTile(
                  title: Text(
                    "Branch",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(branch),
                ),
                ListTile(
                  title: Text(
                    "Books Available to take",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("$maxBook"),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    child: Text("Books Taken"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFF4CA6AF)
,
                      ),
                      minimumSize: MaterialStateProperty.all(Size(90, 45)),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      var bookCollection = MongoUtils.db.collection('book_loans');
                      var cursor = bookCollection.find({'register_number': registerNumber});

                      // Convert the cursor to a list of documents
                      var bookDetails = await cursor.toList();

                      if (bookDetails.isNotEmpty) {
                        // Display the details of all the books
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookLoan(detailsList: bookDetails)),
                        );
                      } else {
                        print('No details found in the library for the given register number.');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
