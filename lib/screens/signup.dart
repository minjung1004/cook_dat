import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                //border: Border.all()
              ),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  child: const Text(
                    'Create Account',
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
                  margin: const EdgeInsets.all(15),
                  color: Colors.white,
                  child: TextField(
                    controller: _userNameController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  color: Colors.white,
                  child: TextField(
                    controller: _fullNameController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: TextField(
                    controller: _pwdController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 15, bottom: 30, left: 15, right: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: const Size(400, 50),
                    ), //stlye
                    onPressed: () async {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _pwdController.text,
                      )
                          .then((value) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(value.user?.uid)
                            .set(//user.toJson()
                                {
                          "email": value.user?.email,
                          "uid": value.user?.uid,
                          "fullname": _fullNameController.text,
                          "username": _userNameController.text,
                        });
                        print("Created New Account");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ]),
            ),
          ],
        )),
      ),
    );
  }
}
