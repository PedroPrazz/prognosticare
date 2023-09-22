import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> handleBackgroundMessage(RemoteMessage message)async {
  print('Title:  ${message.notification?.title}');
  print('Body:  ${message.notification?.body}');
  print('Payload:  ${message.data}');
}

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getFirebaseToken() async {
    try {

      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        print("Token FCM: $token");
        FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      }
      return token;
    } catch (e) {
      print("Erro ao obter o token FCM: $e");
      return null;
    }
  }
}
