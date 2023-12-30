import 'package:flutter/material.dart';
import '../helpers/user_info.dart';

import 'HalamanUtama.dart';
import '../ui/login.dart';
import '../ui/pegawai/pegawai_page.dart';
import '../ui/cuti/cuti_page.dart';
import '../ui/absensi/absensi_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Image(image: AssetImage('../img/logo2.png')),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Beranda()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Data Pegawai'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PegawaiPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box_rounded),
            title: const Text('Data Absensi'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AbsensiPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text('Data Cuti'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CutiPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              UserInfo().logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
