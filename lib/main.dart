import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'firebase_options.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COOK\'DAT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyMainPage(title: 'COOK\'DAT Main Page'),
    );
  }
}

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key, required this.title});
  final String title;

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

//controls all the details: UI and data
class _MyMainPageState extends State<MyMainPage> {
  Future<FirebaseApp> _initialzerFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initialzerFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) return FirstPage();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.orange, Colors.lightGreenAccent]),
      ),
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                height: 300,
                child: const Image(image: AssetImage('assets/logo.png')),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  'COOK\'DAT',
                  style: TextStyle(
                    fontSize: 40,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: Size(400, 50),
                ), //stlye
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Log In', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize: Size(400, 50),
                ), //stlye
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text('Sign Up', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
