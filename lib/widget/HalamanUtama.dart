import 'package:flutter/material.dart';
import '../model/absensi.dart';
import '../model/cuti.dart';
import '../service/absensi_service.dart';
import '../service/pegawai_service.dart';
import '../model/pegawai.dart';
import '../service/cuti_service.dart';
import '../ui/absensi/absensi_page.dart';
import '../ui/pegawai/pegawai_page.dart';
import '../ui/cuti/cuti_page.dart';
import 'sidebar.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List<Pegawai> totaluser = [];
  List<Absensi> totalabsensi = [];
  List<Cuti> totalcuti = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final List<Pegawai> fetchedUsers = await PegawaiService().listData();
    final List<Absensi> fetchedAbsensi = await AbsensiService().listData();
    final List<Cuti> fetchedCuti = await CutiService().listData();
    setState(() {
      totaluser = fetchedUsers;
      totalabsensi = fetchedAbsensi;
      totalcuti = fetchedCuti;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard AbsensiApp"),
      ),
      body:
          //  Column(children: [
          //   Text(
          //     "Data Klinik",
          //     style:
          //         Theme.of(context).textTheme.headlineMedium, // like <h1> in HTML
          //   ),
          GridView.count(
        crossAxisCount: 2,
        children: [
          DashboardCard(
            title: 'Total Data Absensi',
            value: totalabsensi.length.toString(),
            icon: Icons.account_box_rounded,
            color: Colors.blue,
          ),
          DashboardCard(
            title: 'Total Data Cuti',
            value: totalcuti.length.toString(),
            icon: Icons.account_box_outlined,
            color: Colors.orange,
          ),
          DashboardCard(
            title: 'Total Pegawai',
            value: totaluser.length.toString(),
            icon: Icons.person,
            color: Colors.green,
          ),
          // DashboardCard(
          //   title: 'Messages',
          //   value: '10',
          //   icon: Icons.message,
          //   color: Colors.red,
          // ),
          // Add more DashboardCard widgets as needed
        ],
      ),
      // ]),
      drawer: const Sidebar(),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  void navigateToPage(BuildContext context) {
    switch (title) {
      case 'Total Data Absensi':
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AbsensiPage(),
        ));
        break;
      case 'Total Data Cuti':
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CutiPage(),
        ));
        break;
      case 'Total Pegawai':
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PegawaiPage(),
        ));
        break;
      // Add more cases for other cards if needed
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToPage(context),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(12),
        child: ListTile(
          leading: Icon(
            icon,
            size: 40,
            color: color,
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            value,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
