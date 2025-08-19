import 'package:flutter/material.dart';

import 'colors.dart';

class PrivacyPolicyView extends StatelessWidget {
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Política de Privacidad',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: darkgray
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Última actualización: 05/10/2023',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Kora ("nosotros", "nuestra" o "el servicio") se compromete a proteger la privacidad de sus usuarios. Esta Política de Privacidad describe cómo recopilamos, utilizamos, compartimos y protegemos la información personal de los usuarios de nuestra aplicación móvil de mensajería de apoyo emocional ("la aplicación").',
                style: TextStyle(fontSize: 16.0, color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '1. Información que Recopilamos',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Información de Registro: Cuando te registras en la aplicación, te pedimos que proporciones cierta información personal, como tu nombre, dirección de correo electrónico y, opcionalmente, una foto de perfil. Esto nos ayuda a identificarte y a brindarte un servicio personalizado.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 8.0),
              Text(
                'Mensajes y Comunicaciones: La aplicación te permite enviar mensajes y comunicarte con otros usuarios. Guardamos un registro de estas comunicaciones para proporcionarte el servicio y para garantizar tu seguridad.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 8.0),
              Text(
                'Información Técnica: Recopilamos automáticamente información técnica sobre tu dispositivo, como la dirección IP, el tipo de dispositivo, la versión del sistema operativo y la identificación del dispositivo. Utilizamos esta información para fines de diagnóstico y para mejorar la aplicación.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '2. Uso de la Información',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Proporcionar el Servicio: Utilizamos tu información personal para proporcionarte la funcionalidad completa de la aplicación y para facilitar la comunicación entre usuarios.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 8.0),
              Text(
                'Mejora y Desarrollo: Utilizamos información técnica para mejorar y desarrollar nuestra aplicación, así como para solucionar problemas técnicos.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 8.0),
              Text(
                'Comunicación: Podemos enviarte correos electrónicos o notificaciones relacionados con el servicio, como actualizaciones de la aplicación o información importante sobre tu cuenta.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '3. Compartir Información',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Usuarios: Tu nombre y foto de perfil (si decides proporcionar una) serán visibles para otros usuarios de la aplicación. Los mensajes que envíes a otros usuarios serán compartidos con ellos.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 8.0),
              Text(
                'Terceros de Confianza: Podemos compartir información no identificable personalmente con terceros de confianza para fines de análisis y mejora del servicio.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 8.0),
              Text(
                'Requisitos Legales: Podemos divulgar información personal si así lo exige la ley, o si creemos de buena fe que dicha divulgación es necesaria para proteger nuestros derechos, tu seguridad o la seguridad de otros.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '4. Seguridad de la Información',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Implementamos medidas de seguridad técnicas y organizativas para proteger tu información personal. Sin embargo, ninguna transmisión de datos en Internet es completamente segura, y no podemos garantizar la seguridad de tus datos.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '5. Tus Derechos',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Puedes acceder, corregir o eliminar tu información personal en cualquier momento a través de la configuración de tu cuenta en la aplicación.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '6. Cambios en la Política de Privacidad',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Podemos actualizar esta Política de Privacidad ocasionalmente para reflejar cambios en nuestras prácticas de recopilación y uso de datos. Te notificaremos sobre cambios significativos a través de la aplicación o por otros medios.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 40.0),
              Text(
                'Al utilizar nuestra aplicación, aceptas los términos y condiciones de esta Política de Privacidad. Te recomendamos revisar esta política periódicamente para estar informado sobre cómo protegemos tu privacidad.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
