import 'package:ask_pdf/features/splash/splash.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  if (kIsWeb) {
    await Firebase.initializeApp(
      name: 'analytical-chatbot',
      options: const FirebaseOptions(
          apiKey: "AIzaSyC6qzGp_yDk8CpzsLAmC7Zn1NyWcGSjfX4",
          projectId: "analytical-chatbot",
          storageBucket: "analytical-chatbot.appspot.com",
          messagingSenderId: "761201808558",
          appId: "1:761201808558:web:c0b362b6413f6c0e52493f",
          measurementId: "G-FY82GSM62V"),
    );
  } else {
    print('Initializing Firebase ////////////');
    await Firebase.initializeApp();
  }
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2B2C33),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
