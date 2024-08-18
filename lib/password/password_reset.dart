import 'package:flutter/material.dart';

import 'password_controller.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = PasswordController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Password'),
      ),
      body: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailC,
                validator: controller.validateEmail,
                decoration: InputDecoration(
                    hintText: 'Masukkan Email anda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.resetPassword();
                    }
                  },
                  child: const Text('Reset Password')),
            ],
          )),
    );
  }
}
