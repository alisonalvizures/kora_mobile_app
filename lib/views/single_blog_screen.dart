import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/firebase_provider.dart';
import 'colors.dart';

class BlogSingleScreen extends StatefulWidget {
  const BlogSingleScreen({super.key, required this.blogId});

  final String blogId;

  @override
  State<BlogSingleScreen> createState() => _BlogSingleScreenState();
}

class _BlogSingleScreenState extends State<BlogSingleScreen> {

  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getBlogById(widget.blogId);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightbackground[500],
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
            return ListView(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      value.blog!.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: darkpurple),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                // Mostrar subtítulos y párrafos
                for (int i = 0; i < value.blog!.subtitulos.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          value.blog!.subtitulos[i],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkpurple),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          value.blog!.parrafos[i],
                          style: TextStyle(fontSize: 16, color: darkgray),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 20), // Espacio entre cada par de subtítulo y párrafo
                    ],
                  ),
                const Padding(padding: EdgeInsets.all(20)),
                Align(
                  alignment: FractionalOffset.center,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(value.blog!.image),
                    radius: 105,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(40)),
              ],
            );
          }),



    );
  }
}