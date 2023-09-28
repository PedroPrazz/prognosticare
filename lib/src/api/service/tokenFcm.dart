// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prognosticare/src/api/service/firebase_messaging_service.dart';
import 'package:prognosticare/src/config/uri.dart';


final storage = FlutterSecureStorage();

class TokenFCM {

  static Future<bool> postToken() async {
    String? idPessoa = await storage.read(key: 'user_id');
    String? token = await storage.read(key: 'token');

    
      FirebaseMessagingService firebaseMessagingService = FirebaseMessagingService();
      String? fcmToken = await firebaseMessagingService.getFirebaseToken();  
    

    final url = Uri.parse(UriTest.url.toString()+'/register-person/tokenFCM/$idPessoa');


    try {
      final response = await http.put(
        url,
        body: json.encode({
          'tokenFCM': fcmToken,
        }),
       headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('TokenFCM enviado com Sucesso!!');
        return true;

      } else {
        print('Response Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
