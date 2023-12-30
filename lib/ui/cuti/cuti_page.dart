import 'package:flutter/material.dart';
import '../../model/cuti.dart';
import '../../service/cuti_service.dart';
import 'cuti_form.dart';
import 'cuti_item.dart';
import '../../widget/sidebar.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  Stream<List<Cuti>> getList() async* {
    List<Cuti> data = await CutiService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Cuti"),
        actions: [
          ElevatedButton(
            child: const Text("Tambah Data"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CutiForm()));
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
              return CutiItem(cuti: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
