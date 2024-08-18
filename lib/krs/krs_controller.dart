import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KrsController {
  var search = ''.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController searchC = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>> krsSaya(int semester) async* {
    String email = auth.currentUser!.email!;
    yield* firestore
        .collection('mahasiswa')
        .doc(email)
        .collection('Semester $semester')
        .orderBy('matkul')
        .snapshots();
  }

  Future<void> hapusKrs(int semester, String id) async {
    String email = auth.currentUser!.email!;
    CollectionReference ref = firestore
        .collection('mahasiswa')
        .doc(email)
        .collection('Semester $semester');
    try {
      await ref.doc(id).delete();
      Get.snackbar('Hapus', 'Berhasil menghapus data');
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'Gagal menyimpan data');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> krsPaket(
      String prodi, int semester) async* {
    yield* firestore
        .collection('krs')
        .doc(prodi)
        .collection('matakuliah')
        .where('semester', isEqualTo: semester)
        .snapshots();
  }

  Future<void> simpanKrs(
      int semester, String id, Map<String, dynamic> krs) async {
    String email = auth.currentUser!.email!;
    CollectionReference ref = firestore
        .collection('mahasiswa')
        .doc(email)
        .collection('Semester $semester');
    try {
      await ref.doc(id).set(krs);
      Get.snackbar('Simpan', 'Berhasil menyimpan data');
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'Gagal menyimpan data');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> krsPilihan(
      String prodi, String ajaran, String query) async* {
    yield* firestore
        .collection('krs')
        .doc(prodi)
        .collection('matakuliah')
        .where('ajaran', isEqualTo: ajaran)
        .where('matkul', isGreaterThanOrEqualTo: query)
        .where('matkul', isLessThan: '${query}z')
        .snapshots();
  }
}
