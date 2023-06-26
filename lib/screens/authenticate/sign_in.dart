import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('Sign in to Brew Crew'),
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Register'),
              onPressed: () {
                widget.toggleView();
              },
            )
          ],
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextFormField(onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                }),
                const SizedBox(height: 20.0),
                TextFormField(
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    }),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink[400],
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      print(email);
                      print(password);
                    }),
              ],
            ))));
  }
}