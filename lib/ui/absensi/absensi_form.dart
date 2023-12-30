import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/absensi.dart';
import 'absensi_detail.dart';

import '../../service/Absensi_service.dart';

class AbsensiForm extends StatefulWidget {
  const AbsensiForm({Key? key}) : super(key: key);

  @override
  State<AbsensiForm> createState() => _AbsensiFormState();
}

class _AbsensiFormState extends State<AbsensiForm> {
  final _formKey = GlobalKey<FormState>();
  final _ketCtrl = TextEditingController();
  final _namaPCtrl = TextEditingController();
  final _tanggalAbsensiCtrl = TextEditingController();
  final _jamKeluarCtrl = TextEditingController();
  final _jamMasukCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      DateTime now = new DateTime.now();
      DateTime tanggal = new DateTime(now.year, now.month, now.day);
      String formattedTime = DateFormat.Hms().format(now);

      //tanggal.toString().replaceAll("00:00:00.000", "");
      _tanggalAbsensiCtrl.text =
          tanggal.toString().replaceAll("00:00:00.000", "");
      _jamMasukCtrl.text = formattedTime.toString();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tambah Absensi")),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fieldNamaP(),
                _fieldTglAbsensi(),
                _fieldJamMasuk(),
                _fieldJamKeluar(),
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

  _fieldTglAbsensi() {
    return TextField(
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.red),
        labelText: "Tanggal Absensi",
        hintText: "Input Tanggal Absensi",
        icon: Icon(Icons.calendar_today),
        enabled: false,
      ),
      controller: _tanggalAbsensiCtrl,

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

          _tanggalAbsensiCtrl.text =
              formattedDate; //set output date to TextField value.
        }
      },
    );
  }

  _fieldJamMasuk() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Jam Masuk",
          hintText: "Input Jam Masuk"),
      controller: _jamMasukCtrl,
    );
  }

  _fieldJamKeluar() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Jam Keluar",
          hintText: "Input Jam Keluar"),
      controller: _jamKeluarCtrl,
    );
  }

  _fieldKet() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Keterangan Absensi",
          hintText: "Input Keterangan Absensi"),
      controller: _ketCtrl,
    );
  }

  _pembatas() {
    return const SizedBox(height: 20);
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Absensi absensi = Absensi(
              namaP: _namaPCtrl.text,
              tanggalAbsensi: _tanggalAbsensiCtrl.text,
              jamMasuk: _jamMasukCtrl.text,
              jamKeluar: _jamKeluarCtrl.text,
              ket: _ketCtrl.text);
          await AbsensiService().simpan(absensi).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AbsensiDetail(absensi: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
