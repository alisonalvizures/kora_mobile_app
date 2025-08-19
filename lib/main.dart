import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kora_app/provider/firebase_push_notification.dart';
import 'package:kora_app/views/auth_form_screen.dart';
import 'package:kora_app/views/colors.dart';
import 'package:kora_app/views/firebase_options.dart';
import 'package:kora_app/views/splash_screen.dart';
import 'package:kora_app/views/verify_email_page.dart';
import 'package:provider/provider.dart';
import '../provider/firebase_provider.dart';

Future<void> _backgroundMessageHandler(
    RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    // AwesomeNotifications().initialize(
    //   null,
    //   [
    //     NotificationChannel(
    //       channelKey: 'basic_channel',
    //       channelName: 'Basic notifications',
    //       channelDescription: 'Notification channel for basic tests',
    //     ),
    //   ],
    //   debug: true,
    // );

  FirebaseMessaging.onBackgroundMessage(
      _backgroundMessageHandler);
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get mainColor => null;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider(
        create: (_) => FirebaseProvider(),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    textStyle:
                    const TextStyle(fontSize: 20),
                    minimumSize: const Size.fromHeight(52),
                    backgroundColor: mainColor),
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              )),
          home: SplashScreen(),
        ),
      );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: lightpurple,
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const VerifyEmailPage();
        } else {
          return const AuthPage();
        }
      },
    ),
  );
}
