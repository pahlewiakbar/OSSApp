import 'package:flutter/material.dart';

import 'home_widget.dart';
import '../profil/profil_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> homeWidget = [const HomeWidget(), const ProfilView()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
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
        body: homeWidget.elementAt(index),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profil')
          ],
          selectedIndex: index,
          onDestinationSelected: (value) {
            setState(() {
              index = value;
            });
          },
        ));
  }
}
