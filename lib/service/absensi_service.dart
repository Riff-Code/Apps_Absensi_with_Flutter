import 'package:dio/dio.dart';
import '../helpers/api_client_2.dart';
import '../model/absensi.dart';

class AbsensiService {
  Future<List<Absensi>> listData() async {
    final Response response = await ApiClientKedua().get('absensi');
    final List data = response.data as List;
    List<Absensi> result = data.map((json) => Absensi.fromJson(json)).toList();
    return result;
  }

  Future<Absensi> simpan(Absensi absensi) async {
    var data = absensi.toJson();
    final Response response = await ApiClientKedua().post('absensi', data);
    Absensi result = Absensi.fromJson(response.data);
    return result;
  }

  Future<Absensi> ubah(Absensi absensi, String id) async {
    var data = absensi.toJson();
    final Response response = await ApiClientKedua().put('absensi/$id', data);
    print(response);
    Absensi result = Absensi.fromJson(response.data);
    return result;
  }

  Future<Absensi> getById(String id) async {
    final Response response = await ApiClientKedua().get('absensi/$id');
    Absensi result = Absensi.fromJson(response.data);
    return result;
  }

  Future<Absensi> hapus(Absensi absensi) async {
    final Response response =
        await ApiClientKedua().delete('absensi/${absensi.id}');
    Absensi result = Absensi.fromJson(response.data);
    return result;
  }
}
