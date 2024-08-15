import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'krs_paket.dart';
import 'krs_pilihan.dart';
import 'krs_saya.dart';

class KrsView extends StatelessWidget {
  const KrsView({super.key});

  @override
  Widget build(BuildContext context) {
    var mahasiswa = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Rencana Studi'),
      ),
      body: mahasiswa['lunas'] == false
          ? const Center(
              child: Text('Mohon maaf, anda belum\nmembayar tagihan kuliah'),
            )
          : ListView(
              children: [
                ListTile(
                  onTap: () => Get.to(() => const KrsSaya(),
                      arguments: mahasiswa, transition: Transition.cupertino),
                  leading: const Icon(Icons.book),
                  title: const Text(
                    "KRS Saya",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () => Get.to(() => const KrsPaket(),
                      transition: Transition.cupertino, arguments: mahasiswa),
                  leading: const Icon(Icons.account_box),
                  title: const Text(
                    "KRS Paket",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () => Get.to(() => const KrsPilihan(),
                      transition: Transition.cupertino, arguments: mahasiswa),
                  leading: const Icon(Icons.note),
                  title: const Text(
                    "KRS Pilihan",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
    );
  }
}
