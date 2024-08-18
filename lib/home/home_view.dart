import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = HomeController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/urindo.png',
              width: 30,
            ),
            const SizedBox(
              width: 7,
            ),
            const Text('OSS Urindo')
          ],
        ),
      ),
      body: Obx(
        () => controller.homeWidget.elementAt(controller.index.value),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profil')
          ],
          selectedIndex: controller.index.value,
          onDestinationSelected: (value) {
            controller.index.value = value;
          },
        ),
      ),
    );
  }
}
