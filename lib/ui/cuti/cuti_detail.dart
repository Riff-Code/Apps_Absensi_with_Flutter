import 'package:flutter/material.dart';
import '../../service/cuti_service.dart';
import '../../model/cuti.dart';
import '../../widget/sidebar.dart';
import 'cuti_page.dart';
import 'cuti_update_form.dart';

class CutiDetail extends StatefulWidget {
  final Cuti cuti;

  const CutiDetail({super.key, required this.cuti});

  @override
  State<CutiDetail> createState() => _CutiDetailState();
}

class _CutiDetailState extends State<CutiDetail> {
  Stream<Cuti> getData() async* {
    Cuti data = await CutiService().getById(widget.cuti.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cuti Detail")),
      drawer: const Sidebar(),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Tidak Ditemukan');
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ListTile(
                  title: const Text("Nama Pegawai"),
                  subtitle: Text(snapshot.data.namaP,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Tanggal Mulai"),
                  subtitle: Text(snapshot.data.tanggalMulai,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Tanggal Selesai"),
                  subtitle: Text(snapshot.data.tanggalSelesai,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Jenis Cuti"),
                  subtitle: Text(snapshot.data.jenisCuti,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Keterangan"),
                  subtitle: Text(snapshot.data.ket,
                      style: const TextStyle(fontSize: 20))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _tombolUbah(),
                  _tombolHapus(),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  _tombolUbah() {
    return StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CutiUpdateForm(cuti: snapshot.data)));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Ubah")));
  }

  _tombolHapus() {
    return ElevatedButton(
        onPressed: () async {
          AlertDialog alertDialog = AlertDialog(
            content: const Text("Yakin ingin menghapus data ini?"),
            actions: [
              // tombol ya
              StreamBuilder(
                stream: getData(),
                builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Close the confirmation dialog
                    _hapusData(snapshot.data);
                    // Call the _hapusData function
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CutiPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("YA"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Tidak"),
              )
            ],
          );
          showDialog(context: context, builder: (context) => alertDialog);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Hapus"));
  }

// Function to handle data deletion and navigation
  _hapusData(data) async {
    await CutiService().hapus(data);
    await Future.delayed(Duration.zero);
    if (!context.mounted) return;
    Navigator.of(context).pop(); // Close the confirmation dialog
  }
}
