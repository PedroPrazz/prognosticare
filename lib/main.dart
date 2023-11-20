import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print(message.toString());
}

main() async {
  await initializeDateFormatting('pt_BR');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(primary: CustomColors.customSwatchColor,),
        primarySwatch: CustomColors.customSwatchColor,
        primaryColor: CustomColors.customSwatchColor,
        appBarTheme: AppBarTheme(
          color: CustomColors.customSwatchColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: CustomColors.customSwatchColor,
            onPrimary: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: CustomColors.customSwatchColor,
        ),
        drawerTheme: const DrawerThemeData(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        dialogTheme: const DialogTheme(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        dataTableTheme: DataTableThemeData(
          headingRowColor: MaterialStateProperty.all(CustomColors.customSwatchColor,),
          dataRowColor: MaterialStateProperty.all(Colors.grey[100]),
        ),
        datePickerTheme: DatePickerThemeData(backgroundColor: Colors.white, headerBackgroundColor: CustomColors.customSwatchColor, headerForegroundColor: Colors.white, surfaceTintColor: Colors.white),
        timePickerTheme: TimePickerThemeData(backgroundColor: Colors.white, dialBackgroundColor: Colors.white, hourMinuteColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}
