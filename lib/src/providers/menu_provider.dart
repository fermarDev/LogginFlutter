


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _MenuProvider {
  List<dynamic> opciones = [];
   final storage = const FlutterSecureStorage();

  Future<bool> cargaData(String user, String password) async{
    var response = await http.post(Uri.parse('https://swforms.professionalworld.mx/api/auth/login'), body: jsonEncode({"user": user,
    "password": password}), headers: {'Content-Type': 'application/json; charset=UTF-8',});

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      if(data['token'] != null)  {
        saveToken(data['token']);
        return true;
      } else {
        return false;
      } 
      
    } else {
      return false;
    }
  }

  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> _getToken() async {
    return await storage.read(key: 'token');
  }

  Future<bool> checkToken() async {
    String? token = await _getToken();
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}

final menuProvider = _MenuProvider();