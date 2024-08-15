import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController controller = RegisterController();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Akun'),
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
              validator: controller.validatePassword,
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
              height: 15,
            ),
            TextFormField(
              autocorrect: false,
              controller: controller.nameC,
              validator: controller.validateName,
              decoration: InputDecoration(
                  hintText: 'Nama lengkap',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
              value: controller.pilihKelamin,
              validator: controller.validateKelamin,
              decoration: InputDecoration(
                  hintText: 'Jenis Kelamin',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
              items: ['Laki-laki', 'Perempuan']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  controller.pilihKelamin = value;
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              autocorrect: false,
              readOnly: true,
              controller: controller.tanggalC,
              validator: controller.validateTanggal,
              decoration: InputDecoration(
                  hintText: 'Tanggal Lahir',
                  suffixIcon: const Icon(Icons.calendar_month),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1945),
                    lastDate: DateTime.now());
                if (date == null) {
                  controller.tanggalC.text = '';
                } else {
                  String tanggal =
                      DateFormat('dd MMMM yyyy', 'id_ID').format(date);
                  controller.tanggalC.text = tanggal;
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
              value: controller.pilihProdi,
              validator: controller.validateProdi,
              decoration: InputDecoration(
                  hintText: 'Program Studi',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
              items: [
                'Ilmu Komputer',
                'Sistem Informasi',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) {
                setState(() {
                  controller.pilihProdi = value;
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.createAccount();
                  }
                },
                child: const Text('Buat Akun'))
          ],
        ),
      ),
    );
  }
}
