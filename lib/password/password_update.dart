import 'package:flutter/material.dart';

import 'password_controller.dart';

class PasswordUpdate extends StatefulWidget {
  const PasswordUpdate({super.key});

  @override
  State<PasswordUpdate> createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  PasswordController controller = PasswordController();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
      ),
      body: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                controller: controller.passC,
                obscureText: isObsecure,
                validator: controller.validatePassword,
                decoration: InputDecoration(
                    hintText: 'Masukkan Password baru',
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
