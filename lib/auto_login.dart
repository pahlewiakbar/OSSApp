import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home/home_view.dart';
import 'login/login_view.dart';

class AutoLogin extends StatelessWidget {
  const AutoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Image.asset(
                'asset/urindo.png',
                width: 100,
              ),
            ),
          );
        }
        return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Terjadi Kesalahan'),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.hasData) {
              return const HomeView();
            } else {
              return const LoginView();
            }
          },
        );
      },
    );
  }
}
