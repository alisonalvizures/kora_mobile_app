import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kora_app/views/single_tracking_screen.dart';
import 'package:kora_app/widget/tracking_item.dart';
import 'package:provider/provider.dart';
import '../model/tracking_model.dart';
import '../provider/firebase_provider.dart';
import '../service/notification_service.dart';
import 'colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ListTrackingScreen extends StatefulWidget {
  const ListTrackingScreen({super.key});

  @override
  State<ListTrackingScreen> createState() => _ListTrackingScreenState();
}

class _ListTrackingScreenState extends State<ListTrackingScreen>
    with WidgetsBindingObserver {

  final notificationService = NotificationsService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getAllTracking(FirebaseAuth.instance.currentUser!.uid);

    notificationService.firebaseNotification(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: lightbackground[500],
        appBar: AppBar(
          title: const Text('Seguimiento'),
          automaticallyImplyLeading: false,
          backgroundColor: lightbackground,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 32, color: darkpurple[500]),
          toolbarHeight: 80,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.info),
              color: darkpurple,
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
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TrackingSingleScreen(),
                          ));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: darkpurple[500],
                                  size: 24.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  child: Align(
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text('Agregar emoción de hoy',
                                      style: TextStyle(fontSize: 16,color: gray[500]),),
                                  ),
                                ),
                              ],
                            )
                        )
                    )
                ),
              ),
              const Padding(padding: EdgeInsets.all(15)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Historial',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: lightpink[500]),),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Expanded(
                  child: GroupedListView<TrackingModel, String>(
                    elements: value.trackings,
                    groupBy: (element) {
                      final dateTime = element.dateTime;
                      final formattedDate = DateFormat('EEEE, d MMMM yyyy').format(dateTime);
                      return formattedDate; // Agrupar por el formato 'EEEE, d MMMM yyyy'
                    },
                    groupComparator: (value1, value2) => value2.compareTo(value1), // Sort by date descending
                    itemComparator: (item1, item2) => item1.dateTime.compareTo(item2.dateTime),
                    order: GroupedListOrder.ASC,
                    useStickyGroupSeparators: false,
                    groupSeparatorBuilder: (String value) => Padding(

                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                          color: darkpurple,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        )
                      )
                    ),
                    itemBuilder: (context, element) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    _icon(element.status),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(element.status),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(DateFormat('jm').format(element.dateTime)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ),
              const Padding(padding: EdgeInsets.all(20)),
            ],
          );
        },
      ),
    );
  }

  Widget _icon(String status) {
    IconData icon;
    Color colorIcon;

    switch (status) {
      case 'Excelente':
        icon = Icons.sentiment_very_satisfied_rounded;
        colorIcon = Colors.green;
        break;
      case 'Bien':
        icon = Icons.sentiment_satisfied_rounded;
        colorIcon = Colors.lightGreen;
        break;
      case 'Normal':
        icon = Icons.sentiment_neutral_rounded;
        colorIcon = Colors.amber;
        break;
      case 'Mal':
        icon = Icons.sentiment_dissatisfied_rounded;
        colorIcon = Colors.orange;
        break;
      case 'Muy mal':
        icon = Icons.sentiment_very_dissatisfied_rounded;
        colorIcon = Colors.red;
        break;
      default:
        icon = Icons.sentiment_neutral_rounded;
        colorIcon = Colors.grey;
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Icon(
        icon,
        color: colorIcon,
        size: 45,
      ),
    );
  }
}