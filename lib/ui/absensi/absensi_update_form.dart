// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/absensi.dart';
import '../../service/absensi_service.dart';
import 'absensi_detail.dart';

class AbsensiUpdateForm extends StatefulWidget {
  final Absensi absensi;

  const AbsensiUpdateForm({Key? key, required this.absensi}) : super(key: key);
  @override
  _PasienUpdateFormState createState() => _PasienUpdateFormState();
}

class _PasienUpdateFormState extends State<AbsensiUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _ketCtrl = TextEditingController();
  final _namaPCtrl = TextEditingController();
  final _tanggalAbsensiCtrl = TextEditingController();
  final _jamKeluarCtrl = TextEditingController();
  final _jamMasukCtrl = TextEditingController();
  Future<Absensi> getData() async {
    Absensi data = await AbsensiService().getById(widget.absensi.id.toString());
    setState(() {
      _namaPCtrl.text = widget.absensi.namaP;
      _tanggalAbsensiCtrl.text = widget.absensi.tanggalAbsensi;
      _jamMasukCtrl.text = widget.absensi.jamMasuk;
      _jamKeluarCtrl.text = widget.absensi.jamKeluar;
      _ketCtrl.text = widget.absensi.ket;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Absensi")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNamaP(),
              _fieldTglAbsensi(),
              _fieldJamMasuk(),
              _fieldKet(),
              _fieldJamKeluar(),
              _pembatas(),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
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
          String formattedDate = DateFormat('YYYY-MM-dd').format(pickedDate);

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
          labelText: "Nama Absensi",
          hintText: "Input Nama Absensi"),
      controller: _jamMasukCtrl,
    );
  }

  _fieldJamKeluar() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Alamat Absensi",
          hintText: "Input Alamat Absensi"),
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
          String id = widget.absensi.id.toString();
          await AbsensiService().ubah(absensi, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AbsensiDetail(absensi: value)));
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
