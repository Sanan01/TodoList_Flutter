import 'package:flutter/material.dart';
import 'package:todo_list_app/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          height: 50.0,
          alignment: Alignment.center,
          child: const Text(
            'Welcome to Task List App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      body: const AuthForm(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 50.0,
          alignment: Alignment.center,
          child: const Text(
            'Made by Sanan Baig',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
