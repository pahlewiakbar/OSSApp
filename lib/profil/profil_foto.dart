import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'profil_controller.dart';

class ProfilFoto extends StatefulWidget {
  const ProfilFoto({super.key});

  @override
  State<ProfilFoto> createState() => _ProfilFotoState();
}

class _ProfilFotoState extends State<ProfilFoto> {
  var mahasiswa = Get.arguments;
  var controller = ProfilController();
  File? image;

  Future<void> gallery() async {
    var picker = ImagePicker();
    var foto = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (foto != null) {
        image = File(foto.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Foto'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () => gallery(),
                child: image != null
                    ? CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.transparent,
                        backgroundImage: FileImage(image!),
                      )
                    : mahasiswa['foto'] == ''
                        ? CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                'https://ui-avatars.com/api/?name=${mahasiswa['nama']}'),
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                NetworkImage('${mahasiswa['foto']}'),
                          ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () => controller.uploadFoto(image),
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                child: const Text('Simpan'),
              ),
              const SizedBox(
                height: 5,
              ),
              mahasiswa['foto'] == ''
                  ? const SizedBox()
                  : ElevatedButton(
                      onPressed: () => controller.deleteFoto(),
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.red),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      child: const Text(
                        'Hapus',
                      ))
            ],
          )
        ],
      ),
    );
  }
}
