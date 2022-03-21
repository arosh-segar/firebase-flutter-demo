// ignore_for_file: avoid_print

import 'dart:async';

import 'package:demo_flutter/models/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const String routeName = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User? user = Authentication.userState();
  final _formKey = GlobalKey<FormState>();
  String? _fullName;
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quote Item'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Arosh Segar',
                  labelText: 'Enter your full name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  setState(() {
                    if (value != null) _fullName = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'sample@gmail.com',
                  labelText: 'Enter your email address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  setState(() {
                    if (value != null) _email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  hintText: '*********',
                  labelText: 'Enter your password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  setState(() {
                    if (value != null) _password = value;
                  });
                },
              ),
              Container(
                  padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (await Authentication.registerUser(
                                  _fullName!, _email!, _password!)) {
                                setState(() {
                                  user = Authentication.userState();
                                });
                              }
                            }
                          },
                          child: const Text("Register")),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (await Authentication.signIn(
                                  _email!, _password!)) {
                                setState(() {
                                  user = Authentication.userState();
                                });
                              }
                            }
                          },
                          child: const Text("Login")),
                      ElevatedButton(
                          onPressed: () async {
                            await Authentication.signOut();
                            setState(() {
                              user = Authentication.userState();
                            });
                          },
                          child: const Text("Logout")),
                      Text("User logged " + (user == null ? 'out' : 'in'))
                    ],
                  )),
            ],
          ),
        ));
  }
}
