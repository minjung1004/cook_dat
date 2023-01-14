import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';

class ResetpwdPage extends StatefulWidget {
  const ResetpwdPage({super.key});

  @override
  State<ResetpwdPage> createState() => _ResetpwdPageState();
}

class _ResetpwdPageState extends State<ResetpwdPage> {
  final TextEditingController _emailController = TextEditingController();

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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  //border: Border.all()
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: const Icon(
                        Icons.lock_person_outlined,
                        size: 100,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Trouble Logging In?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: const Text(
                        'Enter your email and we\'ll send you a link to get back into your account.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
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
                    SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size(400, 50),
                      ), //stlye
                      onPressed: () {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(
                                email: _emailController.text)
                            .then((value) => Navigator.of(context).pop());
                      },
                      child: const Text('Send Login Link',
                          style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'or',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
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
                      child: const Text(
                        'Create New Account',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ), //style
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Back To Login',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
