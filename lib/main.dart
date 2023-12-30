import 'package:flutter/material.dart';
import 'widget/HalamanUtama.dart';
import 'ui/login.dart';
import 'helpers/user_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  //print(token);
  runApp(MaterialApp(
    title: "Absensi APP",
    debugShowCheckedModeBanner: false,
    home: token == null ? const Login() : const Beranda(),
  ));
}
