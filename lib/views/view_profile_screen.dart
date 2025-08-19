import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/firebase_provider.dart';
import 'colors.dart';

class ProfileSingleScreen extends StatefulWidget {
  const ProfileSingleScreen({super.key, required this.userId});

  final String userId;

  @override
  State<ProfileSingleScreen> createState() => _ProfileSingleScreenState();
}

class _ProfileSingleScreenState extends State<ProfileSingleScreen> {

  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getCurrentUserById(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
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
                const Padding(padding: EdgeInsets.all(10)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text('Tema a tratar: ' + value.userCurrent!.speciality,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkgray),textAlign: TextAlign.left,),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(value.userCurrent!.about,
                    style: TextStyle(fontSize: 16, color: darkgray),textAlign: TextAlign.left,),
                ),
                const Padding(padding: EdgeInsets.all(40)),
              ],
            );
          }),
    );
  }
}