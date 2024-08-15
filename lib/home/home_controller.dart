import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../login/login_view.dart';

class HomeController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List berita = [
    'https://www.urindo.ac.id/wp-content/uploads/2024/04/banner-web-gelombang.jpg',
    'https://www.urindo.ac.id/wp-content/uploads/2024/05/Jalur-prestasi-masuk-URINDO.jpg',
    'https://www.urindo.ac.id/wp-content/uploads/2023/11/testimoni-mars-urindo-web.jpg',
  ];

  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.offAll(() => const LoginView(), transition: Transition.cupertino);
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan', 'Tidak bisa keluar');
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamMahasiswa() async* {
    String user = auth.currentUser!.email!;
    yield* firestore.collection('mahasiswa').doc(user).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> hariIni(int semester) async* {
    String email = auth.currentUser!.email!;
    yield* firestore
        .collection('mahasiswa')
        .doc(email)
        .collection('Semester $semester')
        .where('hari', isEqualTo: currentDay())
        .orderBy('jam')
        .snapshots();
  }

  String currentDay() {
    var days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    var now = DateTime.now();
    return days[now.weekday - 1];
  }
}
