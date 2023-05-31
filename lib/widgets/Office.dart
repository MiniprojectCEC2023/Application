import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../connections/mongoconn.dart';
import '../main.dart';

class Office extends StatelessWidget {
  final Map<String, dynamic> details;

  const Office({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = details["name"];
    String registerNumber = details["register_number"];
    String semester = details["semester"];
    String branch = details["branch"];
    String route_name = details["route_name"];
    int fee_per_semester = details["fee_per_semester"];
    String fee_paid = details["fee_paid"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Office"),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(
                    "Name",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    name,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Register Number",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    registerNumber,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Semester",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    semester,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Branch",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    branch,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Route",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                 
                  subtitle: Text(
                    "$route_name",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Fee",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                   "₹$fee_per_semester",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Fee Status",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    fee_paid == '1' ? "Fee Paid" : "Fee Not Paid",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: fee_paid == '1' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
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
