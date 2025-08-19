import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kora_app/views/edit_user_screen.dart';
import 'package:kora_app/views/privacy_screen.dart';
import 'package:kora_app/views/terms_conditions_screen.dart';
import 'package:kora_app/views/view_profile_screen.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../provider/firebase_provider.dart';
import 'colors.dart';
import 'package:http/http.dart' as http;

class ListSettingScreen extends StatefulWidget {
  const ListSettingScreen({super.key});

  @override
  State<ListSettingScreen> createState() => _ListSettingScreenState();
}

class _ListSettingScreenState extends State<ListSettingScreen>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Provider.of<FirebaseProvider>(context, listen: false)
      .getCurrentUserById(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<bool> pushNotificationsAllUsers() async {
    String recipientUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    String dataNotifications = '{ '
        ' "to" : "/topics/voluntario" , '
        ' "notification" : {'
        ' "title":"Alerta ⚠" , '
        ' "body":"Alguien necesita apoyo urgente" '
        ' },'
        ' "data" : {'
        ' "uid": "$recipientUid" '
        ' },'
        ' "click_action": "FLUTTER_NOTIFICATION_CLICK" ' // Esto activará la acción en la aplicación Flutter
        ' } ';


    var response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAA5rNxDw0:APA91bGdhodXmUFLpaWvwW2VUEPLVpWABl5z8mLcNQRf_EEojPy-8tmKUyt3-x45aUS2fbP54d--AyCNdsyqOAnaxZkWUVAGnpjvH_PbG0xrmVnkWE3hBZfQqTFSVFr7Guz4wFebZas2',
      },
      body: dataNotifications,
    );
    print(response.body.toString());
    return true;
  }

  Future<bool?> showConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // No se puede cerrar tocando fuera del diálogo
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: Column(
            children: [
              Text('Cuando presiones el botón S.O.S, se enviará una alerta inmediata a nuestros voluntarios para que puedan atenderte en la mayor brevedad posible.'),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Text('Por favor, ten en cuenta que este botón debe utilizarse únicamente en situaciones de emergencia emocional o crisis. Si sientes que tu situación es más grave o peligrosa, te recomendamos que te pongas en contacto con un profesional de la salud mental o busques ayuda médica de emergencia.'),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              SelectableText(
                'Línea telefónica para la prevención del suicidio: 4141',
                style: TextStyle(color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              SelectableText(
                'Hospital General San Juan De Dios: 1ra. Avenida 10-50, Zona 1 , Guatemala. Tel: 2321 9191 (Atención 24/7 para emergencias)',
                style: TextStyle(color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              SelectableText(
                'Hospital Roosevelt Guatemala: 5ta calle, zona 11, Guatemala. Tel: 2321 7400 (Atención 24/7 para emergencias)',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
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

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: lightbackground[500],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: lightbackground,
          toolbarHeight: 40,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => MainPage(),
                    ));
              },
              icon: const Icon(Icons.logout,
                  color: darkpurple),
            ),
          ],
        ),
        body: Consumer<FirebaseProvider>(
          builder: (context, value, child) {
          return ListView(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(60)),
                    Align(
                      alignment: FractionalOffset.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(value.userCurrent!.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: darkpurple),textAlign: TextAlign.left,),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Align(
                      alignment: FractionalOffset.center,
                      child: CircleAvatar(
                        backgroundImage:
                        NetworkImage(value.userCurrent!.image),
                        radius: 65,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(15)),
                    Row(
                      children: [
                        if (value.userCurrent!.role == 'Voluntario')
                        Flexible(
                          flex: 1,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(darkpink[500]),
                              backgroundColor: MaterialStateProperty.all(lightbackground),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ProfileSingleScreen(userId: value.userCurrent!.uid)));
                            },
                            child: Text("Ver Perfil"),
                          ),
                        ),
                        if (value.userCurrent!.role == 'Voluntario')
                        SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(lavender),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          EditUserScreen(userId: value.userCurrent!.uid)));
                            },
                            child: Text("Editar Perfil"),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(30)),
                    if (value.userCurrent!.role == 'Paciente')
                      Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(Size(size.width - 10, 40)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(vertical: 20,horizontal: 20)),
                                backgroundColor: MaterialStateProperty.all(Colors.red[700]),
                                foregroundColor: MaterialStateProperty.all(Colors.white),
                                textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20))
                            ),
                            icon: Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.white,
                            ),
                            label: Text("S.O.S"),
                            onPressed: () async {
                              final isConfirmed = await showConfirmationDialog(context);
                              if (isConfirmed == null || isConfirmed == false) {
                                return; // El usuario canceló el registro
                              } else {
                                pushNotificationsAllUsers();
                              }
                            },
                          ),
                      ),
                    const Padding(padding: EdgeInsets.all(40)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PrivacyPolicyView(),
                            ));
                      },
                      child: Text(
                        'Políticas de Privacidad',
                        style: TextStyle(
                          fontSize: 16,
                          color: gray, // Cambia el color del texto según tus preferencias
                          decoration: TextDecoration.underline, // Subrayar el texto al tocarlo (opcional)
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TermsConditionsView(),
                            ));
                      },
                      child: Text(
                        'Términos y Condiciones de Uso',
                        style: TextStyle(
                          fontSize: 16,
                          color: gray, // Cambia el color del texto según tus preferencias
                          decoration: TextDecoration.underline, // Subrayar el texto al tocarlo (opcional)
                        ),
                      ),
                    ),
                  ],
                )
              ]
          );
        })
    );
    

  }
}