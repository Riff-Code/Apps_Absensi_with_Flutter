import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/pegawai.dart';
import '../../service/pegawai_service.dart';
import '../ui/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _NipPegawaiCtrl = TextEditingController();
  final _namaPegawaiCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _TeleponPegawaiCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Registrasi",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 50),
                Center(
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          _fieldNIPPegawai(),
                          const SizedBox(height: 2),
                          _fieldNamaPegawai(),
                          const SizedBox(height: 2),
                          _fieldTglLahirPegawai(),
                          const SizedBox(height: 2),
                          _fieldTeleponPegawai(),
                          const SizedBox(height: 2),
                          _fieldEmailPegawai(),
                          const SizedBox(height: 2),
                          _fieldPassword(),
                          const SizedBox(height: 5),
                          _tombolSimpan(),
                          const SizedBox(height: 5),
                          _tombolSudahPunyaAkun(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldNIPPegawai() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "NIP Pegawai"),
      controller: _NipPegawaiCtrl,
    );
  }

  Widget _fieldNamaPegawai() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Pegawai"),
      controller: _namaPegawaiCtrl,
    );
  }

  Widget _fieldTglLahirPegawai() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir"),
      controller: _tanggalLahirCtrl,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                1990), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          _tanggalLahirCtrl.text =
              formattedDate; //set output date to TextField value.
        }
      },
    );
  }

  Widget _fieldTeleponPegawai() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nomor Telepon"),
      controller: _TeleponPegawaiCtrl,
    );
  }

  Widget _fieldEmailPegawai() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      controller: _emailCtrl,
    );
  }

  Widget _fieldPassword() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      controller: _passwordCtrl,
      obscureText: true,
    );
  }

  Widget _tombolSimpan() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () async {
          Pegawai pegawai = Pegawai(
            nip: _NipPegawaiCtrl.text,
            namaPegawai: _namaPegawaiCtrl.text,
            tanggalLahir: _tanggalLahirCtrl.text,
            nomorTelepon: _TeleponPegawaiCtrl.text,
            email: _emailCtrl.text,
            password: _passwordCtrl.text,
          );
          await PegawaiService().simpan(pegawai).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            );
          });
        },
        child: const Text("Register"),
      ),
    );
  }

  Widget _tombolSudahPunyaAkun() {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      },
      child: const Text("Sudah punya akun?"),
    );
  }
}
