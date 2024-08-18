import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'password_controller.dart';

class PasswordUpdate extends StatelessWidget {
  const PasswordUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = PasswordController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
      ),
      body: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Obx(
                () => TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  controller: controller.passC,
                  obscureText: controller.isObsecure.value,
                  validator: controller.validatePassword,
                  decoration: InputDecoration(
                      hintText: 'Masukkan Password baru',
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
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.updatePassword();
                    }
                  },
                  child: const Text('Ubah Password'))
            ],
          )),
    );
  }
}
