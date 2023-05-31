import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../connections/mongoconn.dart';
import '../global/globals.dart';
import '../main.dart';

class BookLoan extends StatefulWidget {
  const BookLoan({Key? key, required this.detailsList}) : super(key: key);

  final List<Map<String, dynamic>> detailsList;

  @override
  _BookLoanState createState() => _BookLoanState();
}

class _BookLoanState extends State<BookLoan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books Taken"),
        centerTitle: true,
        backgroundColor: Color(0xFF142D34),
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
        elevation: 20,
      ),
      body: ListView.builder(
        itemCount: widget.detailsList.length,
        itemBuilder: (BuildContext context, int index) {
          var title = widget.detailsList[index]['title'];
          var returnDate = widget.detailsList[index]['return_date'].toString();

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Return Date: $returnDate',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
             /*  trailing: Icon(
                Icons.bookmark,
                color: Color.fromARGB(255, 140, 53, 53),
              ), */
            ),
          );
        },
      ),
    );
  }
}
