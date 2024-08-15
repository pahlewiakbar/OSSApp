import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profil_controller.dart';

class ProfilKrs extends StatefulWidget {
  const ProfilKrs({super.key});

  @override
  State<ProfilKrs> createState() => _ProfilKrsState();
}

class _ProfilKrsState extends State<ProfilKrs> {
  var mahasiswa = Get.arguments;
  ProfilController controller = ProfilController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan KRS'),
      ),
      body: mahasiswa['lunas'] == false
          ? const Center(
              child: Text('Mohon maaf, anda belum\nmembayar tagihan kuliah'),
            )
          : ListView(
              padding: const EdgeInsets.all(15),
              children: [
                const Text(
                  "Semester",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField(
                  value: mahasiswa['semester'],
                  decoration: InputDecoration(
                      hintText: 'Pilih Semester',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                  items: [1, 2, 3]
                      .map((e) => DropdownMenuItem(
                          value: e, child: Text('Semester $e')))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      mahasiswa['semester'] = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Ajaran",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField(
                  value: mahasiswa['ajaran'],
                  decoration: InputDecoration(
                      hintText: 'Pilih Ajaran',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                  items: ['Ganjil', 'Genap']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      mahasiswa['ajaran'] = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () => controller.ubahPengaturan(
                        mahasiswa['semester'], mahasiswa['ajaran']),
                    child: const Text('Ubah Pengaturan'))
              ],
            ),
    );
  }
}
