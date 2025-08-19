// ignore_for_file: unused_import
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kora_app/views/colors.dart';

import '../../main.dart';
import '../../service/notification_service.dart';
import '../service/firebase_firestone_service.dart';
import '../views/forgot_password_page.dart';

class LoginWidget extends StatefulWidget {
  final Function() onClickedSignUp;
  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static final notifications = NotificationsService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Image.asset('assets/images/logo-tw.png', width: MediaQuery.of(context).size.width * 0.8,),
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,

                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  errorStyle: TextStyle(
                    color: Colors.white,
                  ),
                  fillColor: Colors.white,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),

                style: TextStyle(color: Colors.white),
                autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                validator: (email) => email != null &&
                        !EmailValidator.validate(email)
                    ? 'Ingrese un email válido'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  errorStyle: TextStyle(
                    color: Colors.white,
                  ),
                  fillColor: Colors.white,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),

                ),
                obscureText: true,
                style: TextStyle(color: Colors.white),
                autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null && value.length < 6
                        ? 'Ingrese min. 6 caracteres'
                        : null,
              ),
              const SizedBox(height: 20),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(60),
                      backgroundColor: Colors.white,
                    ),
                    label: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 24, color: darkpurple),
                    ),
                    icon: const Icon(Icons.lock_open, size: 32, color: darkpurple,),
                    onPressed: signIn,
                  )
              ),
              const SizedBox(height: 24),
              GestureDetector(
                child: Text(
                  '¿Olvidó su contraseña?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) =>
                      const ForgotPasswordPage(),
                )),
              ),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20,),
                  text: '¿No tiene cuenta?  ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Crear cuenta',
                      style: TextStyle(
                        decoration:
                            TextDecoration.underline,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) =>
    //       const Center(child: CircularProgressIndicator()),
    // );

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestoreService.updateUserData(
        {'lastActive': DateTime.now()},
      );

      await notifications.requestPermission();
      await notifications.getToken();
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text(e.message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    //
    // navigatorKey.currentState!
    //     .popUntil(((route) => route.isFirst));
  }
}
