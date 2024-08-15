import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilController {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController nimC = TextEditingController();
  TextEditingController kelaminC = TextEditingController();
  TextEditingController prodiC = TextEditingController();
  TextEditingController fakultasC = TextEditingController();
  TextEditingController tanggalC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFoto(File? image) async {
    String email = auth.currentUser!.email!;
    String imageName = '$email.jpg';
    Reference reference = storage.ref().child('foto').child(imageName);
    if (image != null) {
      try {
        await reference.putFile(image);
        String imageUrl = await reference.getDownloadURL();
        await firestore
            .collection('mahasiswa')
            .doc(email)
            .update({'foto': imageUrl});
        Get.back();
        Get.snackbar('Ubah Foto', 'Berhasil mengubah foto');
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', 'Gagal mengubah foto');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Pilih foto terlebih dahulu');
    }
  }

  Future<void> deleteFoto() async {
    String email = auth.currentUser!.email!;
    String imageName = '$email.jpg';
    Reference reference = storage.ref().child('foto').child(imageName);
    try {
      await firestore.collection('mahasiswa').doc(email).update({'foto': ''});
      await reference.delete();
      Get.back();
      Get.snackbar('Hapus Foto', 'Berhasil menghapus foto');
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'Gagal menghapus foto');
    }
  }

  Future<void> ubahProfil() async {
    String email = auth.currentUser!.email!;
    try {
      await firestore
          .collection('mahasiswa')
          .doc(email)
          .update({'nama': nameC.text});
      Get.back();
      Get.snackbar('Ubah Profil', 'Berhasil mengubah Profil');
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'Gagal mengubah Profil');
    }
  }

  Future<void> ubahPengaturan(int semester, String ajaran) async {
    String email = auth.currentUser!.email!;
    try {
      await firestore
          .collection('mahasiswa')
          .doc(email)
          .update({'semester': semester, 'ajaran': ajaran});
      Get.back();
      Get.snackbar('Ubah Pengaturan', 'Pengaturan berhasil di ubah');
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'Pengaturan gagal di ubah');
    }
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
}
