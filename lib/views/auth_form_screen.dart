import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../provider/firebase_push_notification.dart';
import '../widget/login_widget.dart';
import '../widget/signup_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  void initState() {
    super.initState();

    // Inicializa notificaciones solo si hay un usuario autenticado
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      initializeNotificationsAndSaveToken(user);
    }
  }

  Future<void> initializeNotificationsAndSaveToken(User user) async {
    await FirebaseApi().initNotifications();
    await FirebaseMessaging.instance.getInitialMessage();
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
        ),
      ],
      debug: true,
    );
  }

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(onClickedSignUp: toggle)
      : SignUpWidget(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
