// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:kora_app/views/firebase_auth_services.dart';
// import 'package:kora_app/views/login_screen.dart';
// import 'colors.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
//
// }
//
// class _RegisterScreenState extends State<RegisterScreen>  {
//
//   final FirebaseAuthService _auth = FirebaseAuthService();
//   final _auth2 = FirebaseAuth.instance;
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _password2Controller = TextEditingController();
//
//   @override
//   void dispose(){
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _password2Controller.dispose();
//     super.dispose();
//   }
//
//   final _accountList = ["Paciente", "Voluntario"];
//   _RegisterScreenState(){
//     _selectedVal = _accountList[0];
//   }
//   String? _selectedVal = "";
//
//   @override
//   Widget build(BuildContext context){
//
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: Container(
//           color: lightbackground[500],
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('CREAR CUENTA', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32, color: darkpurple )),
//                 Image.asset('assets/images/underline.png', width: size.width * 0.8,),
//                 const Padding(padding: EdgeInsets.all(40)),
//                 SizedBox(
//                   width: size.width - 100,
//                   child: TextField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Nombre',
//                       contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//                       labelStyle: TextStyle(color: darkpurple, fontSize: 16, backgroundColor: Colors.transparent ),
//                     ),
//                     textAlign: TextAlign.left,
//                     style: const TextStyle(color: darkpurple, fontSize: 16),
//
//                   ),
//
//                 ),
//                 const Padding(padding: EdgeInsets.all(15)),
//                 SizedBox(
//                   width: size.width - 100,
//                   child: TextField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Email',
//                       contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//                       labelStyle: TextStyle(color: darkpurple, fontSize: 16, backgroundColor: Colors.transparent ),
//                     ),
//                     textAlign: TextAlign.left,
//                     style: const TextStyle(color: darkpurple, fontSize: 16),
//
//                   ),
//
//                 ),
//                 const Padding(padding: EdgeInsets.all(15)),
//                 SizedBox(
//                   width: size.width - 100,
//                   child: TextField(
//                     obscureText: true,
//                     controller: _passwordController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Contraseña',
//                       contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//                       labelStyle: TextStyle(color: darkpurple, fontSize: 16, backgroundColor: Colors.transparent ),
//                     ),
//                     textAlign: TextAlign.left,
//                     style: const TextStyle(color: darkpurple, fontSize: 16),
//
//                   ),
//
//                 ),
//                 const Padding(padding: EdgeInsets.all(15)),
//                 SizedBox(
//                   width: size.width - 100,
//                   child: TextField(
//                     obscureText: true,
//                     controller: _password2Controller,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Confirmar contraseña',
//                       contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//                       labelStyle: TextStyle(color: darkpurple, fontSize: 16, backgroundColor: Colors.transparent ),
//                     ),
//                     textAlign: TextAlign.left,
//                     style: const TextStyle(color: darkpurple, fontSize: 16),
//
//                   ),
//
//                 ),
//                 const Padding(padding: EdgeInsets.all(15)),
//                 SizedBox(
//                   width: size.width - 100,
//                   child: DropdownButton(
//                     value: _selectedVal!.isNotEmpty ? _selectedVal : null,
//                     items: _accountList.map(
//                         (e){
//                           return DropdownMenuItem(value: e,child: Text(e),);
//                         }
//                     ).toList(),
//                     onChanged: (val){
//                       setState(() {
//                         _selectedVal = val as String;
//                       });
//                     },
//                     style: const TextStyle(color: darkpurple, fontSize: 16, backgroundColor: Colors.transparent ),
//                   )
//
//                 ),
//                 const Padding(padding: EdgeInsets.all(40)),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                       shape: MaterialStateProperty.all(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       minimumSize: MaterialStateProperty.all(Size(size.width - 100, 40)),
//                       padding: MaterialStateProperty.all(
//                           const EdgeInsets.symmetric(vertical: 20,horizontal: 20)),
//                       backgroundColor: MaterialStateProperty.all(darkpink[500]),
//                       foregroundColor: MaterialStateProperty.all(Colors.white),
//                       textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20))
//                   ),
//                   onPressed: _signUp,
//                   child: Text("REGISTRARSE"),
//                 ),
//                 // const Padding(padding: EdgeInsets.all(5)),
//                 // const Text('Olvidé mi contraseña', style: TextStyle(fontSize: 16, color: lightpink, decoration: TextDecoration.underline )),
//               ],
//             ),
//           )
//
//       ),
//     );
//   }
//
//   void _signUp() async {
//     String name = _nameController.text;
//     String email = _emailController.text;
//     String pass = _passwordController.text;
//     String pass2 = _password2Controller.text;
//     String role = _selectedVal.toString();
//
//     await _auth.signUpWithEmailAndPassword(email, pass).then((value) =>
//     {
//       postDetailsToFirestore(email, role, name)
//     }).catchError((e){});
//
//   }
//   postDetailsToFirestore(String email, String role, String name) async {
//     // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     var user = _auth2.currentUser;
//     CollectionReference ref = FirebaseFirestore.instance.collection('users');
//     ref.doc(user!.uid).set({'email': email, 'role': role, 'name': name});
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (_) => const LoginScreen(),
//         ));
//   }
//
//
// }