import 'package:flutter/material.dart';
import '../../model/absensi.dart';
import 'absensi_detail.dart';

class AbsensiItem extends StatelessWidget {
  final Absensi absensi;
  const AbsensiItem({super.key, required this.absensi});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AbsensiDetail(absensi: absensi)));
      },
      child: Card(
        child: ListTile(
          title: Text(absensi.namaP),
        ),
      ),
    );
  }
}
