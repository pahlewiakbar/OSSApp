import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'auto_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting('id_ID');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'OSS Urindo',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      home: AutoLogin(),
    );
  }
}
