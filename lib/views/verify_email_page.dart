import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kora_app/views/colors.dart';
import 'body_app_screen.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() =>
      _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified =
        FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified =
          FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      final snackBar =
          SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const BodyAppScreen()
      : Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Verificar Email',
                  style: TextStyle(fontSize: 32, color: darkpurple, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Se ha enviado un email a la dirección de correo que ha proporcionado.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor: darkpurple,
                      ),
                      icon: const Icon(Icons.email, size: 32),
                      label: const Text(
                        'Reenviar Email',
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: canResendEmail
                          ? sendVerificationEmail
                          : null,
                    ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 24, color: darkpurple),
                  ),
                  onPressed: () =>
                      FirebaseAuth.instance.signOut(),
                ),
              ],
            ),
          ),
        );
}
