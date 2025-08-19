import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Regresar'),
          automaticallyImplyLeading: true,
          backgroundColor: darkpurple[500],
          titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, ),
          toolbarHeight: 60,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Image.asset('assets/images/logo-t.png', width: MediaQuery.of(context).size.width * 0.8,),
                  const SizedBox(height: 10),
                  const Text(
                    'Se enviará un email para\nrestablecer su contraseña.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    cursorColor: darkpurple,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(
                        color: darkpurple,
                      ),
                      fillColor: darkpurple,
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: darkpurple,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: darkpurple,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: darkpurple,
                        ),
                      ),
                      focusColor: darkpurple,
                      hintStyle: TextStyle(color: darkpurple),
                      labelStyle: TextStyle(color: darkpurple),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: darkpurple,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Ingrese un email válido'
                            : null,
                  ),
                  const SizedBox(height: 20),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(60),
                          backgroundColor: darkpurple,
                        ),
                        icon: const Icon(Icons.email_outlined),
                        label: const Text(
                          'Restablecer',
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: verifyEmail,
                      ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Future verifyEmail() async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(child: CircularProgressIndicator()),
    // );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      const snackBar =
          SnackBar(content: Text('El email ha sido enviado.'));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
