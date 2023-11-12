
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/config/uri.dart';
import 'package:prognosticare/src/models/profilesModel.dart';
import 'package:prognosticare/src/routes/app_pages.dart';


final storage = FlutterSecureStorage();
class ProfileService {

  static Future<List<Profile>> getProfiles(String? id) async {

    String? token = await storage.read(key: 'token');

    final url = Uri.parse(UriServidor.url.toString()+'/register-person/profiles/$id');

    try {
      final response = await http.get(
        url,
        headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
       List<dynamic> jsonDataList = json.decode(response.body);

        List<Profile> profiles = jsonDataList.map((jsonData) {
          return Profile.fromJson(jsonData);
        }).toList();

        return profiles;


      }if(response.statusCode == 404) {
        Get.offNamed(PagesRoutes.homeRoute);
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Exeption no método profiles Erro no Try/Catch');
      
    }
    return [];
  }
}
