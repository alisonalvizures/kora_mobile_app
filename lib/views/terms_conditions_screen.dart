import 'package:flutter/material.dart';

import 'colors.dart';

class TermsConditionsView extends StatelessWidget {
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
                'Términos y Condiciones de Uso',
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
                '1. Aceptación de los Términos y Condiciones',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Al acceder y utilizar esta aplicación móvil (en adelante, "la Aplicación"), usted acepta estar legalmente obligado por los siguientes Términos y Condiciones de Uso ("Términos"). Si no está de acuerdo con estos Términos, por favor, absténgase de utilizar la Aplicación.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '2. Cambios en los Términos',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Nos reservamos el derecho de modificar estos Términos en cualquier momento sin previo aviso. Es su responsabilidad revisar regularmente estos Términos para estar al tanto de las actualizaciones. El uso continuado de la Aplicación después de la publicación de cualquier cambio constituirá su aceptación de dichos cambios.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '3. Uso de la Aplicación',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Usted acepta utilizar la Aplicación de acuerdo con todas las leyes y regulaciones aplicables y estos Términos. No utilizará la Aplicación para ningún propósito ilegal o no autorizado.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '4. Contenido de la Aplicación',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'La Aplicación puede contener información, texto, enlaces, gráficos, imágenes, videos u otros materiales (en adelante, "el Contenido"). El Contenido se proporciona únicamente para su información general y no constituye asesoramiento profesional, médico, legal o financiero. No asumimos ninguna responsabilidad por la exactitud o integridad del Contenido.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '5. Privacidad',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'El uso de la Aplicación está sujeto a nuestra Política de Privacidad. Al utilizar la Aplicación, usted acepta las prácticas de recopilación y uso de datos descritas en nuestra Política de Privacidad.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '6. Propiedad Intelectual',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'La Aplicación y su Contenido están protegidos por derechos de autor, marcas registradas y otras leyes de propiedad intelectual. Usted acepta no modificar, copiar, distribuir, transmitir, mostrar, realizar, reproducir, publicar, otorgar licencias, crear trabajos derivados ni vender ninguna parte de la Aplicación o su Contenido sin nuestro consentimiento previo por escrito.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '7. Limitación de Responsabilidad',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Usted utiliza la Aplicación bajo su propio riesgo. No somos responsables de ningún daño directo, indirecto, incidental, especial o consecuente que surja del uso o la imposibilidad de uso de la Aplicación.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '8. Terminación',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Nos reservamos el derecho de suspender o cancelar su acceso a la Aplicación en cualquier momento y por cualquier motivo sin previo aviso.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 16.0),
              Text(
                '9. Ley Aplicable',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: darkgray
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Estos Términos se regirán e interpretarán de acuerdo con las leyes de Guatemala, sin tener en cuenta sus disposiciones de conflicto de leyes.',
                style: TextStyle(fontSize: 16.0,color: darkgray),
              ),
              SizedBox(height: 40.0),
              Text(
                'Gracias por utilizar nuestra Aplicación.',
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
