import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../password/password_reset.dart';
import '../register/register_view.dart';
import 'login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController controller = LoginController();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Image.asset(
              'asset/urindo.png',
              width: 150,
              height: 150,
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
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              controller: controller.passC,
              obscureText: isObsecure,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObsecure = !isObsecure;
                        });
                      },
                      icon: !isObsecure
                          ? const Icon(
                              Icons.remove_red_eye,
                              color: Colors.blue,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                            ))),
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
                onPressed: () => Get.to(() => const RegisterView(),
                    transition: Transition.cupertino),
                child: const Text('Buat Akun')),
            TextButton(
                onPressed: () => Get.to(() => const PasswordReset(),
                    transition: Transition.cupertino),
                child: const Text('Lupa Password'))
          ],
        ),
      )),
    );
  }
}
