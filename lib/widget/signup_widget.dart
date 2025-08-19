// ignore_for_file: unused_import
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kora_app/views/colors.dart';

import '../../main.dart';
import '../../service/firebase_storage_service.dart';
import '../../service/media_service.dart';
import '../../service/notification_service.dart';
import '../service/firebase_firestone_service.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  Uint8List? file;
  static final notifications = NotificationsService();
  final _accountList = ["Paciente", "Voluntario"];
  String? _selectedVal = "";


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () async {
                    final pickedImage =
                    await MediaService.pickImage();
                    setState(() => file = pickedImage!);
                  },
                  child: file != null
                      ? CircleAvatar(
                    radius: 50,
                    backgroundImage: MemoryImage(file!),
                  )
                      : const CircleAvatar(
                    radius: 50,
                    backgroundColor: lightpurple,
                    child: Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 40),
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
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
                  autovalidateMode:
                  AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                  email != null && email.isEmpty
                      ? 'El nombre no puede estar vacio.'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
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
                  autovalidateMode:
                  AutovalidateMode.onUserInteraction,
                  validator: (email) => email != null &&
                      !EmailValidator.validate(email)
                      ? 'Ingrese un email válido.'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
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
                  obscureText: true,
                  autovalidateMode:
                  AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                  value != null && value.length < 6
                      ? 'Ingrese min. 6 caracteres'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Contraseña',
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
                  obscureText: true,
                  autovalidateMode:
                  AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                  passwordController.text !=
                      confirmPasswordController.text
                      ? 'Las contraseñas no coinciden'
                      : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Seleccione un rol',
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
                        )
                    ),
                    value: _selectedVal!.isNotEmpty ? _selectedVal : "Paciente",
                    items: _accountList.map(
                        (e){
                          return DropdownMenuItem(value: e,child: Text(e),);
                        }
                    ).toList(),
                    onChanged: (val){
                      setState(() {
                        _selectedVal = val as String;
                      });
                    },
                    style: const TextStyle(color: darkpurple, fontSize: 16, backgroundColor: Colors.transparent ),
                  )

                ),
                const SizedBox(height: 20),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(60),
                          backgroundColor: darkpurple,
                        ),
                        icon: const Icon(Icons.arrow_back,
                            size: 32),
                        label: const Text(
                          'Crear Cuenta',
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: signUp),
                ),
                const SizedBox(height: 50),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: darkgray, fontSize: 20),
                    text: '¿Ya tiene una cuenta?  ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Iniciar Sesión',
                        style: TextStyle(
                          decoration:
                          TextDecoration.underline,
                          color: darkgray,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // No se puede cerrar tocando fuera del diálogo
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text('Gracias por unirse a Kora. Queremos informarle que almacenamos los chats en nuestra base de datos para mejorar la experiencia. Al continuar, está aceptando esto'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false); // Cierra el diálogo y devuelve 'false'
              },
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(true); // Cierra el diálogo y devuelve 'true'
              },
            ),
          ],
        );
      },
    );
  }



  Future signUp() async {
    final isConfirmed = await showConfirmationDialog(context);
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    if (file == null) {
      const snackBar = SnackBar(
          content: Text('Por favor seleccione una foto de perfil'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (isConfirmed == null || isConfirmed == false) {
      return; // El usuario canceló el registro
    } else {
      try {
        final user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        final image =
        await FirebaseStorageService.uploadImage(
            file!, 'image/profile/${user.user!.uid}');

        await FirebaseFirestoreService.createUser(
          image: image,
          email: user.user!.email!,
          uid: user.user!.uid,
          name: nameController.text,
          role: _selectedVal.toString(),
        );

        await notifications.requestPermission();
        await notifications.getToken();
      } on FirebaseAuthException catch (e) {
        final snackBar = SnackBar(content: Text(e.message!));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }



    // navigatorKey.currentState!
    //     .popUntil(((route) => route.isFirst));
  }
}
