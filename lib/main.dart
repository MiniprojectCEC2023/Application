import 'package:flutter/material.dart';
import 'package:miniapp/connections/mongoconn.dart';
import 'package:miniapp/widgets/home.dart';
import 'global/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoUtils.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = ''; // Error message variable
  bool isPasswordVisible = false; // Track password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF142D34)
,
      appBar: AppBar(
        title: Text("Student App"),
        centerTitle: true,
        backgroundColor: Color(0xFF142D34)
,

        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey,
                offset: Offset(0, 2),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFF142D34),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Enter your username",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xFF142D34),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF142D34),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF142D34),
                      width: 2,
                    ),
                  ),
                ),
                style: TextStyle(color: Color(0xFF142D34)),
                controller: usernameController,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xFF142D34),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color(0xFF142D34),
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF142D34),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF142D34),
                      width: 2,
                    ),
                  ),
                ),
                style: TextStyle(color: Color(0xFF142D34)),
                              obscureText: !isPasswordVisible,
      
                controller: passwordController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final collection = MongoUtils.db.collection('student');
                  var username = usernameController.text;
                  var password = passwordController.text;

                  var result = await collection.findOne(
                    {
                      'name': username,
                      'register_number': password,
                    },
                  );

                  if (result != null) {
                    print('Login success!');
                    registerNumber = passwordController.text;
                    name = usernameController.text;
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  } else {
                    setState(() {
                      errorMessage = 'Invalid username or password'; // Set error message
                    });
                  }
                },
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CA6AF),
                  minimumSize: Size(180, 50),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

