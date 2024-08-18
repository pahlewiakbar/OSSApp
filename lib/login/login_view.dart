import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../password/password_reset.dart';
import '../register/register_view.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = LoginController();
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Image.asset(
              'asset/urindo.png',
              width: 130,
              height: 130,
            ),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                'One Stop Service',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Center(
              child: Text(
                'Universitas Respati Indonesia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailC,
              validator: controller.validateEmail,
              decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                controller: controller.passC,
                obscureText: controller.isObsecure.value,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () => controller.isObsecure.toggle(),
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: !controller.isObsecure.value
                              ? Colors.blue
                              : Colors.grey,
                        ))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.login();
                  }
                },
                child: const Text('Masuk')),
            TextButton(
                onPressed: () => Get.to(() => const RegisterView()),
                child: const Text('Buat Akun')),
            TextButton(
                onPressed: () => Get.to(() => const PasswordReset()),
                child: const Text('Lupa Password'))
          ],
        ),
      )),
    );
  }
}
