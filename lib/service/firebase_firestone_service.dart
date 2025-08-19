import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/message_model.dart';
import '../model/user_model.dart';
import 'firebase_storage_service.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<void> createUser({
    required String name,
    required String image,
    required String email,
    required String uid,
    required String role,
  }) async {
    final user = UserModel(
      uid: uid,
      email: email,
      name: name,
      image: image,
      role: role,
      isOnline: true,
      lastActive: DateTime.now(),
    );

    await firestore
        .collection('users')
        .doc(uid)
        .set(user.toJson());

    print(user.toJson());
  }

  static Future<void> updateUser({
    required String name,
    required String uid,
    String? image,
    String? speciality,
    String? about,
  }) async {
    final userUpdateData = {
      'name': name,
      'image': image,
      'speciality': speciality,
      'about': about,
      'lastActive': FieldValue.serverTimestamp(), // Actualiza la última actividad.
      // Agrega otros campos que desees actualizar.
    };
    await firestore
        .collection('users')
        .doc(uid)
        .update(userUpdateData);
    print('Datos del usuario actualizados');
  }


  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
  }) async {
    final message = Message(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> addImageMessage({
    required String receiverId,
    required Uint8List file,
  }) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');

    final message = Message(
      content: image,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.image,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> _addMessageToChat(
      String receiverId,
      Message message,
      ) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(message.toJson());
  }

  static Future<void> updateUserData(
      Map<String, dynamic> data) async =>
      await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);

  static Future<List<UserModel>> searchUser(
      String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("name", isGreaterThanOrEqualTo: name)
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }

  static Future<List<UserModel>> getAllVolunteers(
      String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("role", isGreaterThanOrEqualTo: "Voluntario")
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }

}
