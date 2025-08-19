import 'dart:typed_data';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/firebase_provider.dart';
import '../service/firebase_firestone_service.dart';
import '../service/firebase_storage_service.dart';
import '../service/media_service.dart';
import 'colors.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key, required this.userId});

  final String userId;

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();

}

class _EditUserScreenState extends State<EditUserScreen>  {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final aboutController = TextEditingController();
  Uint8List? file;

  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getCurrentUserById(widget.userId);
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  final _accountList = ["Ansiedad", "Estrés", "Desahogo Emocional"];
  _EditUserScreenState(){
    _selectedVal = _accountList[0];
  }
  String? _selectedVal = "";
  String? image = "";

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
      // Llena los controladores de texto con los datos actuales del usuario.

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Regresar'),
        automaticallyImplyLeading: true,
        backgroundColor: darkpurple[500],
        titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, ),
        toolbarHeight: 60,
        elevation: 0,
      ),
      body: Consumer<FirebaseProvider>(
          builder: (context, value, child) {
            // print('Imagen del usuario: ${value.userCurrent?.image}');
            image = value.userCurrent!.image ?? '';
            aboutController.text = value.userCurrent!.about ?? '';
            nameController.text = value.userCurrent!.name ?? '';

            return SingleChildScrollView(
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
                      ) : value.userCurrent!.image != null
                      ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(value.userCurrent!.image),
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
                    if (value.userCurrent!.role == 'Voluntario')
                    SizedBox(
                      height: 200,
                      child: TextFormField(

                        controller: aboutController,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        // textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Acerca de mi',
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
                      ),
                    ),
                    if (value.userCurrent!.role == 'Voluntario')
                    const SizedBox(height: 20),
                    if (value.userCurrent!.role == 'Voluntario')
                    SizedBox(
                        width: size.width,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Seleccione una especialidad',
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
                          value: _selectedVal!.isNotEmpty ? _selectedVal : "",
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
                        icon: const Icon(Icons.save,
                            size: 32),
                        label: const Text(
                          'Guardar Cambios',
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: updateUserData,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future updateUserData() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    // Realiza la autenticación del usuario nuevamente para obtener el usuario actual.
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Si hay un usuario autenticado, actualiza sus datos.
      try {
        if(file != null){
          image =
          await FirebaseStorageService.uploadImage(
              file!, 'image/profile/${user!.uid}');
        }
        // Aquí puedes actualizar los campos del usuario en Firestore o cualquier otro
        // lugar donde almacenes los datos del usuario.
        await FirebaseFirestoreService.updateUser(
          uid: user.uid,
          name: nameController.text,
          image: image,
          speciality: _selectedVal.toString(),
          about: aboutController.text,
          // Actualiza otros campos según sea necesario.
        );

        const snackBar = SnackBar(content: Text('Datos actualizados con éxito'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on FirebaseAuthException catch (e) {
        final snackBar = SnackBar(content: Text(e.message!));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      // Manejar el caso en el que no hay usuario autenticado.
    }
  }

}
