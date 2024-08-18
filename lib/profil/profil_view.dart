import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../password/password_update.dart';
import 'profil_foto.dart';
import 'profil_krs.dart';
import 'profil_update.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = HomeController();
    return StreamBuilder(
      stream: controller.streamMahasiswa(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var mahasiswa = snapshot.data!.data()!;
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 15),
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(
                      () => const ProfilFoto(),
                      arguments: mahasiswa,
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: mahasiswa['foto'] == ''
                          ? NetworkImage(
                              "https://ui-avatars.com/api/?name=${mahasiswa['nama']}",
                            )
                          : NetworkImage('${mahasiswa['foto']}'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    mahasiswa['nama'],
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    '${mahasiswa['nim']}',
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () => Get.to(
                  () => const ProfilUpdate(),
                  arguments: mahasiswa,
                ),
                leading: const Icon(Icons.people),
                title: const Text(
                  "Ubah Profil",
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () =>
                    Get.to(() => const ProfilKrs(), arguments: mahasiswa),
                leading: const Icon(Icons.settings),
                title: const Text(
                  "Pengaturan KRS",
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () => Get.to(() => const PasswordUpdate()),
                leading: const Icon(Icons.key),
                title: const Text(
                  "Ubah Password",
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Keluar'),
                    content: const Text(
                      'Apakah anda yakin ingin keluar?',
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => controller.logout(),
                          child: const Text('Ya')),
                      TextButton(
                          onPressed: () => Get.back(),
                          child: const Text(
                            'Tidak',
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  ),
                ),
                leading: const Icon(Icons.logout),
                title: const Text(
                  "Keluar",
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: Text('Terjadi Kesalahan'),
        );
      },
    );
  }
}
