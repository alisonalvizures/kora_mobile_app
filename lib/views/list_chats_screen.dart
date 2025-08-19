import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/firebase_provider.dart';
import '../service/firebase_firestone_service.dart';
import '../service/notification_service.dart';
import '../widget/user_item.dart';
import 'colors.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen>
    with WidgetsBindingObserver {
  final notificationService = NotificationsService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Provider.of<FirebaseProvider>(context, listen: false)
        .getUserChatUIDs(FirebaseAuth.instance.currentUser!.uid);

    notificationService.firebaseNotification(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseFirestoreService.updateUserData({
          'lastActive': DateTime.now(),
          'isOnline': false,
        });
        break;

      case AppLifecycleState.inactive:

      case AppLifecycleState.paused:

      case AppLifecycleState.detached:
        FirebaseFirestoreService.updateUserData(
            {'isOnline': false});
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Mensajes'),
      automaticallyImplyLeading: false,
      backgroundColor: darkpurple[500],
      titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 32, ),
      toolbarHeight: 80,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.info),
          color: Colors.white,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Información importante'),
                  content: SingleChildScrollView(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Queremos agradecerte por ser parte de nuestra comunidad de apoyo emocional. Kora está aquí para brindarte un espacio seguro donde puedes compartir tus pensamientos, sentimientos y preocupaciones con nuestros amables voluntarios. Sin embargo, es importante recordar que Kora no es un sustituto de la terapia profesional.',
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        Text(
                          'Nuestra aplicación está diseñada para ayudar en casos leves de ansiedad, estrés, pánico o cuando simplemente necesitas desahogarte emocionalmente. Nuestros voluntarios están aquí para escucharte y ofrecer apoyo en momentos difíciles. Sin embargo, si estás experimentando problemas emocionales más graves o necesitas atención especializada, te instamos a buscar la ayuda de un profesional de la salud mental.',
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        Text(
                          'Tu bienestar es nuestra prioridad, y para situaciones más serias, es fundamental que te pongas en contacto con profesionales capacitados que pueden brindarte la atención que necesitas. Si sientes que estás en crisis o necesitas asistencia inmediata, por favor comunícate con los siguientes números de contacto:',
                        ),
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
                        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        Text(
                          'Recuerda que no estás solo en esto, y siempre hay ayuda disponible para ti. Kora está aquí para apoyarte en tu camino hacia el bienestar emocional, pero sabemos que hay momentos en los que necesitas un enfoque más especializado.',
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        Text(
                          'Gracias por confiar en Kora como un recurso en tu viaje emocional. Juntos, podemos superar los desafíos y cuidar de nuestra salud mental. ♡',
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cerrar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    ),
    body: Consumer<FirebaseProvider>(
        builder: (context, value, child) {
          return ListView.separated(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: value.usersList.length,
            separatorBuilder: (context, index) =>
            const SizedBox(height: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => value
                .usersList[index].uid !=
                FirebaseAuth.instance.currentUser?.uid
                ? UserItem(user: value.usersList[index])
                : const SizedBox(),
          );
        }),
  );
}
