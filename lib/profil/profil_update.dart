import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profil_controller.dart';

class ProfilUpdate extends StatelessWidget {
  const ProfilUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    var mahasiswa = Get.arguments;
    var controller = ProfilController();
    controller.nameC.text = mahasiswa['nama'];
    controller.nimC.text = '${mahasiswa['nim']}';
    controller.kelaminC.text = mahasiswa['kelamin'];
    controller.prodiC.text = mahasiswa['prodi'];
    controller.tanggalC.text = mahasiswa['tanggal'];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ubah Profil'),
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              const Text(
                "Nama",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: controller.nameC,
                autocorrect: false,
                validator: controller.validateName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "NIM",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: controller.nimC,
                autocorrect: false,
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Jenis Kelamin",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: controller.kelaminC,
                autocorrect: false,
                readOnly: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Tanggal Lahir",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: controller.tanggalC,
                autocorrect: false,
                readOnly: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Program Studi",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: controller.prodiC,
                readOnly: true,
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.ubahProfil();
                    }
                  },
                  child: const Text('Ubah Profil'))
            ],
          ),
        ));
  }
}
