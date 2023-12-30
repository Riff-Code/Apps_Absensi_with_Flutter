import 'package:flutter/material.dart';
import '../../model/cuti.dart';
import 'cuti_detail.dart';

class CutiItem extends StatelessWidget {
  final Cuti cuti;
  const CutiItem({super.key, required this.cuti});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CutiDetail(cuti: cuti)));
      },
      child: Card(
        child: ListTile(
          title: Text(cuti.namaP),
        ),
      ),
    );
  }
}
