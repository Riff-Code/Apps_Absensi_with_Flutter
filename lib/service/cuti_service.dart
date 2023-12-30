import 'package:dio/dio.dart';
import '../helpers/api_client_2.dart';
import '../model/cuti.dart';

class CutiService {
  Future<List<Cuti>> listData() async {
    final Response response = await ApiClientKedua().get('cuti');
    final List data = response.data as List;
    List<Cuti> result = data.map((json) => Cuti.fromJson(json)).toList();
    return result;
  }

  Future<Cuti> simpan(Cuti cuti) async {
    var data = cuti.toJson();
    final Response response = await ApiClientKedua().post('cuti', data);
    Cuti result = Cuti.fromJson(response.data);
    return result;
  }

  Future<Cuti> ubah(Cuti cuti, String id) async {
    var data = cuti.toJson();
    final Response response = await ApiClientKedua().put('cuti/$id', data);
    print(response);
    Cuti result = Cuti.fromJson(response.data);
    return result;
  }

  Future<Cuti> getById(String id) async {
    final Response response = await ApiClientKedua().get('cuti/$id');
    Cuti result = Cuti.fromJson(response.data);
    return result;
  }

  Future<Cuti> hapus(Cuti cuti) async {
    final Response response = await ApiClientKedua().delete('cuti/${cuti.id}');
    Cuti result = Cuti.fromJson(response.data);
    return result;
  }
}
