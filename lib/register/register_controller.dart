import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../home/home_view.dart';

class RegisterController {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController tanggalC = TextEditingController();
  String? pilihKelamin;
  String? pilihProdi;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createAccount() async {
    CollectionReference user = firestore.collection('mahasiswa');
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailC.text, password: passC.text);
      await user.doc(emailC.text).set({
        'nama': nameC.text,
        'kelamin': pilihKelamin,
        'tanggal': tanggalC.text,
        'prodi': pilihProdi,
        'nim': 0,
        'semester': 1,
        'ajaran': 'Ganjil',
        'lunas': true,
        'foto': ''
      });
      Get.offAll(() => const HomeView(), transition: Transition.cupertino);
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'Email sudah digunakan');
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

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (name.contains(RegExp(r'[0-9]'))) {
      return 'Nama tidak boleh mengandung angka';
    }
    return null;
  }

  String? validateKelamin(String? kelamin) {
    if (kelamin == null) {
      return 'Jenis Kelamin tidak boleh kosong';
    }
    return null;
  }

  String? validateTanggal(String? tanggal) {
    if (tanggal == '' || tanggal == null) {
      return 'Tanggal Lahir tidak boleh kosong';
    }
    return null;
  }

  String? validateProdi(String? prodi) {
    if (prodi == null) {
      return 'Prodi tidak boleh kosong';
    }
    return null;
  }
}
