import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'signup.dart';
import 'resetpwd.dart';

//LOGIN PAGE

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

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
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              flex: 50,
              child: Container(
                width: 300,
                height: 300,
                margin: const EdgeInsets.only(top: 70),
                child: const Image(image: AssetImage('assets/logo.png')),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
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
            Expanded(
              flex: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  //border: Border.all()
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      color: Colors.white,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: _pwdController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 25),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.green,
                            ), //style
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()),
                              );
                            },
                            child: const Text('Create Account'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 115, right: 25),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blue,
                            ), //stlye
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ResetpwdPage()),
                              );
                            },
                            child: const Text('Forgot password?'),
                          ),
                        ),
                      ], //children
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: const Size(400, 50),
                      ), //stlye
                      onPressed: () async {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _pwdController.text)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        });
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ], // children
                ),
              ),
            ),
          ], // children
        ),
      ),
    );
  } //widget
}  //class