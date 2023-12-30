import 'package:flutter/material.dart';
import '../../model/absensi.dart';
import '../../service/absensi_service.dart';
import 'absensi_form.dart';
import 'absensi_item.dart';
import '../../widget/sidebar.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  Stream<List<Absensi>> getList() async* {
    List<Absensi> data = await AbsensiService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Absensi"),
        actions: [
          ElevatedButton(
            child: const Text("Tambah Data"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AbsensiForm()));
            },
          )
        ],
      ),
      drawer: const Sidebar(),
      body: StreamBuilder(
        stream: getList(),
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
            return const Text('Data Kosong');
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return AbsensiItem(absensi: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
