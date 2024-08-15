import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'krs_controller.dart';

class KrsPaket extends StatelessWidget {
  const KrsPaket({super.key});

  @override
  Widget build(BuildContext context) {
    var mahasiswa = Get.arguments;
    KrsController controller = KrsController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('KRS Paket'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          DropdownButtonFormField(
            value: mahasiswa['semester'],
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            items: [
              DropdownMenuItem(
                  value: mahasiswa['semester'],
                  child: Text('Semester ${mahasiswa['semester']}'))
            ],
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream:
                controller.krsPaket(mahasiswa['prodi'], mahasiswa['semester']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs;
                return data.isEmpty
                    ? const Center(
                        child: Text('Belum ada data'),
                      )
                    : Column(
                        children: data.map((e) {
                          var krs = e.data();
                          return Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        krs['matkul'],
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        krs['hari'],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () => controller.simpanKrs(
                                        mahasiswa['semester'], e.id, krs),
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    child: const Text('Simpan'))
                              ],
                            ),
                          );
                        }).toList(),
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
          )
        ],
      ),
    );
  }
}
