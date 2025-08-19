import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:kora_app/views/body_app_screen.dart';
import 'package:kora_app/views/body_app_screen_user.dart';
import 'package:kora_app/views/list_tracking_screen.dart';
import 'colors.dart';
import 'package:intl/intl.dart';

class TrackingSingleScreen extends StatefulWidget {
  const TrackingSingleScreen({Key? key}) : super(key: key);

  @override
  State<TrackingSingleScreen> createState() => _TrackingSingleScreenState();
}

class _TrackingSingleScreenState extends State<TrackingSingleScreen> {
  String? _selectedStatus = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbackground[500],
      appBar: AppBar(
        title: const Text('Regresar'),
        automaticallyImplyLeading: true,
        backgroundColor: darkpurple[500],
        titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        toolbarHeight: 60,
        elevation: 0,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¿Cómo te sientes hoy?',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: darkpurple[500]),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _icon(Icons.sentiment_very_dissatisfied_rounded, 'Muy mal', Colors.red),
                  _icon(Icons.sentiment_dissatisfied_rounded, 'Mal', Colors.orange),
                  _icon(Icons.sentiment_neutral_rounded, 'Normal', Colors.amber),
                  _icon(Icons.sentiment_satisfied_rounded, 'Bien', Colors.lightGreen),
                  _icon(Icons.sentiment_very_satisfied_outlined, 'Excelente', Colors.green),
                ],
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 25,
                    color: lightpink[500],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Text(
                    DateFormat('EEEE, d MMMM y').format(DateTime.now()),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: lightpink[500]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(60),
                      backgroundColor: darkpurple,
                    ),
                    icon: const Icon(
                      Icons.save,
                      size: 32,
                    ),
                    label: const Text(
                      'Confirmar',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: saveTrackingRecord,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon(IconData icon, String status, Color colorIcon) {
    bool isSelected = _selectedStatus == status;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkResponse(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? colorIcon : Colors.grey,
              size: 45,
            ),
            Text(
              status,
              style: TextStyle(
                color: isSelected ? gray[500] : Colors.grey,
              ),
            ),
          ],
        ),
        onTap: () => setState(() {
          _selectedStatus = status;
        }),
      ),
    );
  }

  Future<void> saveTrackingRecord() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String status = _selectedStatus!;
      DateTime dateTime = DateTime.now();

      CollectionReference userTrackingCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tracking');

      await userTrackingCollection.add({
        'uid': uid,
        'status': status,
        'dateTime': dateTime,
      });
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const BodyAppUserScreen(),
          ));
      print('Registro de seguimiento guardado con éxito.');
    } catch (e) {
      print('Error al guardar el registro de seguimiento: $e');
    }
  }
}
