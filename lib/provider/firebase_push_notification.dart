import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');

    final firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);
    // Guarda el token FCM en Firestore
    await userRef.set({'fcmToken': fCMToken}, SetOptions(merge: true));
  }
}