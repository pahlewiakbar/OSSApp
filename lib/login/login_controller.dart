import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../home/home_view.dart';

class LoginController {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: emailC.text, password: passC.text);
      Get.offAll(() => const HomeView(), transition: Transition.cupertino);
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'Email atau Password salah');
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(email)) {
      return 'Format Email tidak valid';
    }
    return null;
  }
}
