import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kora_app/views/single_chat_screen.dart';
import 'body_app_screen_user.dart';
import 'body_app_screen_volunteer.dart';

class BodyAppScreen extends StatefulWidget {
  const BodyAppScreen({super.key});

  @override
  State<BodyAppScreen> createState() => _BodyAppScreenState();

}

class _BodyAppScreenState extends State<BodyAppScreen> {

  @override
  void initState() {
    super.initState();
    checkUserRoleAndSubscribe();
    _initFirebaseMessaging();
  }

  void _initFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final String? uid = message.data['uid'];

      if (uid != null && uid.isNotEmpty) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatScreen(userId: uid),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final String? uid = message.data['uid'];

      if (uid != null && uid.isNotEmpty) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatScreen(userId: uid),
          ),
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    final String uid = message.data['uid'];

    if (uid != null && uid.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatScreen(userId: uid),
        ),
      );
    }
  }

  Future<void> checkUserRoleAndSubscribe() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (documentSnapshot.exists) {
      String role = documentSnapshot.get('role');
      if (role == "Voluntario") {
        subscribeToVolunteerTopic();
      }
    }
  }

  void subscribeToVolunteerTopic() {
    FirebaseMessaging.instance.subscribeToTopic('voluntario').then((value) {
      print('Suscripción exitosa al tema "voluntario"');
    }).catchError((error) {
      print('Error al suscribirse al tema "voluntario": $error');
    });
  }


  @override
  Widget build(BuildContext context){
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "Voluntario") {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const BodyAppScreenVolunteer(),
              ));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const BodyAppUserScreen(),
              ));
        }
      }
    });


    return Scaffold(

    );
  }
}