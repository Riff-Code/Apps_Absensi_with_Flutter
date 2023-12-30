// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/cuti.dart';
import '../../service/cuti_service.dart';
import 'cuti_detail.dart';

class CutiUpdateForm extends StatefulWidget {
  final Cuti cuti;

  const CutiUpdateForm({Key? key, required this.cuti}) : super(key: key);
  @override
  _PasienUpdateFormState createState() => _PasienUpdateFormState();
}

class _PasienUpdateFormState extends State<CutiUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _ketCtrl = TextEditingController();
  final _namaPCtrl = TextEditingController();
  final _tanggalMulaiCtrl = TextEditingController();
  final _tanggalSelesaiCtrl = TextEditingController();
  final _jenisCutiCtrl = TextEditingController();
  Future<Cuti> getData() async {
    Cuti data = await CutiService().getById(widget.cuti.id.toString());
    setState(() {
      _namaPCtrl.text = widget.cuti.namaP;
      _tanggalMulaiCtrl.text = widget.cuti.tanggalMulai;
      _jenisCutiCtrl.text = widget.cuti.jenisCuti;
      _tanggalSelesaiCtrl.text = widget.cuti.tanggalSelesai;
      _ketCtrl.text = widget.cuti.ket;
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
      appBar: AppBar(title: const Text("Ubah Cuti")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNamaP(),
              _fieldTglMulai(),
              _fieldTglSelesai(),
              _fieldjenisCuti(),
              _fieldKet(),
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

  _fieldTglMulai() {
    return TextField(
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.red),
        labelText: "Tanggal Cuti",
        hintText: "Input Tanggal Cuti",
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
        labelText: "Tanggal Cuti",
        hintText: "Input Tanggal Cuti",
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

  _fieldjenisCuti() {
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
              jenisCuti: _jenisCutiCtrl.text,
              tanggalSelesai: _tanggalSelesaiCtrl.text,
              ket: _ketCtrl.text);
          String id = widget.cuti.id.toString();
          await CutiService().ubah(cuti, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CutiDetail(cuti: value)));
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
