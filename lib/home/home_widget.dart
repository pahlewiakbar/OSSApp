import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import '../krs/krs_view.dart';
import 'home_bar.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = HomeController();
    return StreamBuilder(
      stream: controller.streamMahasiswa(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Terjadi Kesalahan'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var mahasiswa = snapshot.data!.data()!;
        return ListView(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        backgroundImage: mahasiswa['foto'] == ''
                            ? NetworkImage(
                                "https://ui-avatars.com/api/?name=${mahasiswa['nama']}",
                              )
                            : NetworkImage('${mahasiswa['foto']}'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mahasiswa['nama'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(mahasiswa['prodi'],
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Badge(
                      child: Icon(
                        Icons.notifications,
                        color: Colors.grey.shade700,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: const MenuItem(icon: 'asset/bayar.png', text: 'Bayar'),
                ),
                GestureDetector(
                  onTap: () =>
                      Get.to(() => const KrsView(), arguments: mahasiswa),
                  child: const MenuItem(icon: 'asset/krs.png', text: 'KRS'),
                ),
                GestureDetector(
                  child:
                      const MenuItem(icon: 'asset/jadwal.png', text: 'Jadwal'),
                ),
                GestureDetector(
                  child: const MenuItem(icon: 'asset/nilai.png', text: 'Nilai'),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Berita Terbaru',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 7,
            ),
            CarouselSlider(
                items: controller.berita
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            e,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 120,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) =>
                      controller.indicator.value = index,
                )),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.berita.map((e) {
                  int index = controller.berita.indexOf(e);
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.fromLTRB(3, 10, 3, 0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.indicator.value == index
                            ? Colors.blue
                            : Colors.grey),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Jadwal Hari Ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 7,
            ),
            StreamBuilder(
                stream: controller.hariIni(mahasiswa['semester']),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Terjadi Kesalahan'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data!.docs;
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('Tidak ada jadwal hari ini'),
                    );
                  } else {
                    return Column(
                      children: data.map((e) {
                        var jadwal = e.data();
                        return Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  jadwal['matkul'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(jadwal['jam'])
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                })
          ],
        );
      },
    );
  }
}
