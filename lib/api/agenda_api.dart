import 'package:agenda_front/services/local_storage.dart';
import 'package:dio/dio.dart';

class AgendaAPI {
  static final Dio _dio = Dio();

  static void configureDio() {
    // Base del url
    _dio.options.baseUrl = 'http://localhost:8080/api';
    // Configurar Headers

    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': LocalStorage.prefs.getString('token')
    };
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);
      return resp.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future httpPost(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future httpPut(String path, Map<String, dynamic> data) async {
    try {
      final resp = await _dio.put(path, data: data);
      return resp.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future httpDelete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final resp = await _dio.delete(path, data: formData);
      return resp.data;
    } catch (e) {
      rethrow;
    }
  }
}
