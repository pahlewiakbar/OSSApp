import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'register_controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = RegisterController();
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
            Obx(
              () => TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                controller: controller.passC,
                obscureText: controller.isObsecure.value,
                validator: controller.validatePassword,
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
              validator: controller.validateKelamin,
              decoration: InputDecoration(
                  hintText: 'Jenis Kelamin',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
              items: ['Laki-laki', 'Perempuan']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (kelamin) => controller.pilihKelamin.value = kelamin!,
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
              validator: controller.validateProdi,
              decoration: InputDecoration(
                  hintText: 'Program Studi',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
              items: [
                'Ilmu Komputer',
                'Sistem Informasi',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (prodi) => controller.pilihProdi.value = prodi!,
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
