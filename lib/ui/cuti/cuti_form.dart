import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/cuti.dart';
import 'cuti_detail.dart';

import '../../service/cuti_service.dart';

class CutiForm extends StatefulWidget {
  const CutiForm({Key? key}) : super(key: key);

  @override
  State<CutiForm> createState() => _CutiFormState();
}

class _CutiFormState extends State<CutiForm> {
  final _formKey = GlobalKey<FormState>();
  final _ketCtrl = TextEditingController();
  final _namaPCtrl = TextEditingController();
  final _tanggalMulaiCtrl = TextEditingController();
  final _tanggalSelesaiCtrl = TextEditingController();
  final _jenisCutiCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tambah Cuti")),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fieldNamaP(),
                _fieldTglMulai(),
                _fieldTglSelesai(),
                _fieldJenisCuti(),
                _fieldKet(),
                _pembatas(),
                _tombolSimpan()
              ],
            ),
          ),
        ));
  }

  _fieldNamaP() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Nama Pegawai",
          hintText: "Input Nama Pegawai"),
      controller: _namaPCtrl,
    );
  }

  _fieldTglMulai() {
    return TextField(
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.red),
        labelText: "Tanggal Mulai",
        hintText: "Input Tanggal Mulai",
        icon: Icon(Icons.calendar_today),
      ),
      controller: _tanggalMulaiCtrl,

      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                1990), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          _tanggalMulaiCtrl.text =
              formattedDate; //set output date to TextField value.
        }
      },
    );
  }

  _fieldTglSelesai() {
    return TextField(
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.red),
        labelText: "Tanggal Selesai",
        hintText: "Input Tanggal Selesai",
        icon: Icon(Icons.calendar_today),
      ),
      controller: _tanggalSelesaiCtrl,

      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                1990), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          _tanggalSelesaiCtrl.text =
              formattedDate; //set output date to TextField value.
        }
      },
    );
  }

  _fieldJenisCuti() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Jenis Cuti",
          hintText: "Input Jenis Cuti"),
      controller: _jenisCutiCtrl,
    );
  }

  _fieldKet() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Keterangan Cuti",
          hintText: "Input Keterangan Cuti"),
      controller: _ketCtrl,
    );
  }

  _pembatas() {
    return const SizedBox(height: 20);
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Cuti cuti = Cuti(
              namaP: _namaPCtrl.text,
              tanggalMulai: _tanggalMulaiCtrl.text,
              tanggalSelesai: _tanggalSelesaiCtrl.text,
              jenisCuti: _jenisCutiCtrl.text,
              ket: _ketCtrl.text);
          await CutiService().simpan(cuti).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CutiDetail(cuti: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
