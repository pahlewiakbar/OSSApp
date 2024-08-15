import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/login_view.dart';

class PasswordController {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePassword() async {
    var user = auth.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(passC.text);
        await auth.signOut();
        Get.offAll(() => const LoginView(), transition: Transition.cupertino);
        Get.snackbar('Ubah Password', 'Berhasil mengubah Password');
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', 'Gagal mengubah Password');
      }
    }
  }

  Future<void> resetPassword() async {
    try {
      await auth.sendPasswordResetEmail(email: emailC.text);
      Get.back();
      Get.snackbar(
          'Lupa Password', 'Berhasil mengirim Email untuk reset Password');
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'Reset Password gagal');
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

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (password.length < 8) {
      return 'Password harus terdiri dari minimal 8 karakter';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password harus mengandung setidaknya satu huruf besar (A-Z)';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password harus mengandung setidaknya satu huruf kecil (a-z)';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password harus mengandung setidaknya satu angka (0-9)';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password harus mengandung setidaknya satu karakter khusus';
    }
    return null;
  }
}
