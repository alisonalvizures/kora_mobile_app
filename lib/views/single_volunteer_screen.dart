import 'package:flutter/material.dart';
import 'package:kora_app/views/single_chat_screen.dart';
import 'package:provider/provider.dart';
import '../provider/firebase_provider.dart';
import 'colors.dart';

class VolunteerSingleScreen extends StatefulWidget {
  const VolunteerSingleScreen({super.key, required this.userId});

  final String userId;

  @override
  State<VolunteerSingleScreen> createState() => _VolunteerSingleScreenState();
}

class _VolunteerSingleScreenState extends State<VolunteerSingleScreen> {

  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getUserById(widget.userId);
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
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              physics: const BouncingScrollPhysics(),
              children: [
                const Padding(padding: EdgeInsets.all(20)),
                Align(
                  alignment: FractionalOffset.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(value.user!.name,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: darkpurple),textAlign: TextAlign.left,),
                    ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Align(
                    alignment: FractionalOffset.center,
                    child: CircleAvatar(
                      backgroundImage:
                      NetworkImage(value.user!.image),
                      radius: 65,
                    ),
                  ),
                const Padding(padding: EdgeInsets.all(10)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text('Tema a tratar: ' + value.user!.speciality,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkgray),textAlign: TextAlign.left,),
                ),
                  const Padding(padding: EdgeInsets.all(10)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(value.user!.about,
                      style: TextStyle(fontSize: 16, color: darkgray),textAlign: TextAlign.left,),
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(size.width - 40, 40)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(vertical: 20,horizontal: 0)),
                                  backgroundColor: MaterialStateProperty.all(darkpurple[500]),
                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                  textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16))
                              ),
                              onPressed: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            ChatScreen(userId: value.user!.uid)
                                    )
                                );
                              },
                              child: Text("ENVIAR MENSAJE"),
                            ),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(40)),
              ],
            );
          }),
    );
  }
}