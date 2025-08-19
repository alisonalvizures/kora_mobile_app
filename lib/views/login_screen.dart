// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:kora_app/views/body_app_screen.dart';
// import 'package:kora_app/views/body_app_screen_volunteer.dart';
// import 'colors.dart';
// import 'firebase_auth_services.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen>  {
//
//   final FirebaseAuthService _auth = FirebaseAuthService();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//
//   @override
//   void dispose(){
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context){
//
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         color: lightbackground[500],
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('INICIAR SESIÓN', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32, color: darkpurple )),
//               Image.asset('assets/images/underline.png', width: size.width * 0.8,),
//               const Padding(padding: EdgeInsets.all(40)),
//               SizedBox(
//                 width: size.width - 100,
//                 child: TextField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                     contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//                     labelStyle: TextStyle(color: darkpurple, fontSize: 16, backgroundColor: Colors.transparent ),
//                   ),
//                   textAlign: TextAlign.left,
//                   style: const TextStyle(color: darkpurple, fontSize: 16),
//
//                 ),
//
//               ),
//               const Padding(padding: EdgeInsets.all(20)),
//               SizedBox(
//                 width: size.width - 100,
//                 child: TextField(
//                   obscureText: true,
//                   controller: _passwordController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Contraseña',
//                     contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//                     labelStyle: TextStyle(color: darkpurple, fontSize: 16, backgroundColor: Colors.transparent ),
//                   ),
//                   textAlign: TextAlign.left,
//                   style: const TextStyle(color: darkpurple, fontSize: 16),
//
//                 ),
//
//               ),
//               const Padding(padding: EdgeInsets.all(40)),
//               ElevatedButton(
//                 style: ButtonStyle(
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                   minimumSize: MaterialStateProperty.all(Size(size.width - 100, 40)),
//                   padding: MaterialStateProperty.all(
//                       const EdgeInsets.symmetric(vertical: 20,horizontal: 20)),
//                   backgroundColor: MaterialStateProperty.all(darkpink[500]),
//                   foregroundColor: MaterialStateProperty.all(Colors.white),
//                   textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20))
//                 ),
//                 onPressed: _signIn,
//                 child: Text("INGRESAR"),
//               ),
//               // const Padding(padding: EdgeInsets.all(5)),
//               // const Text('Olvidé mi contraseña', style: TextStyle(fontSize: 16, color: lightpink, decoration: TextDecoration.underline )),
//             ],
//           ),
//         )
//
//       ),
//     );
//   }
//
//   Future signIn() async {
//     final isValid = formKey.currentState!.validate();
//     if (!isValid) return;
//
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) =>
//       const Center(child: CircularProgressIndicator()),
//     );
//
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//
//       await FirebaseFirestoreService.updateUserData(
//         {'lastActive': DateTime.now()},
//       );
//
//       await notifications.requestPermission();
//       await notifications.getToken();
//     } on FirebaseAuthException catch (e) {
//       final snackBar = SnackBar(content: Text(e.message!));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//
//     // navigatorKey.currentState!
//     //     .popUntil(((route) => route.isFirst));
//   }
//
//
//   // void _signIn() async {
//   //   String email = _emailController.text;
//   //   String pass = _passwordController.text;
//   //
//   //   try {
//   //     UserCredential userCredential =
//   //     await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //       email: email,
//   //       password: pass,
//   //     );
//   //     route();
//   //   } on FirebaseAuthException catch (e) {
//   //     if (e.code == 'user-not-found') {
//   //       print('No user found for that email.');
//   //     } else if (e.code == 'wrong-password') {
//   //       print('Wrong password provided for that user.');
//   //     }
//   //   }
//   //
//   // }
//
//   void route() {
//     User? user = FirebaseAuth.instance.currentUser;
//     var kk = FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.uid)
//         .get()
//         .then((DocumentSnapshot documentSnapshot) {
//       if (documentSnapshot.exists) {
//         if (documentSnapshot.get('role') == "Voluntario") {
//           Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (_) => const BodyAppScreenVolunteer(),
//               ));
//         }else if (documentSnapshot.get('role') == "Paciente"){
//           Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (_) => const BodyAppScreen(),
//               ));
//         }
//       } else {
//         print('Document does not exist on the database');
//       }
//     });
//   }
// }