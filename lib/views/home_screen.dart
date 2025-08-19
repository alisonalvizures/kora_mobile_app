import 'package:flutter/material.dart';
import 'package:kora_app/views/register_screen.dart';
import '../widget/login_widget.dart';
import '../widget/signup_widget.dart';
import 'colors.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  {

  bool isLogin = true;

  @override
  Widget build(BuildContext context){
    void toggle() => setState(() => isLogin = !isLogin);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: lightpurple[500],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo-tw.png', width: size.width * 0.8,),
              const Padding(padding: EdgeInsets.all(20)),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                    ),
                  minimumSize: MaterialStateProperty.all(Size(size.width - 100, 40)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 20,horizontal: 20)),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(darkpink[500]),
                ),
                onPressed: (){
                  LoginWidget(onClickedSignUp: toggle);
                },
                child: Text("INICIAR SESIÓN"),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(size.width - 100, 40)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 20,horizontal: 20)),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(darkpink[500]),
                ),
                onPressed: (){
                  SignUpWidget(onClickedSignIn: toggle);
                },
                child: Text("REGISTRARSE"),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              Image.asset('assets/images/home_image.png', width: size.width * 0.9,),
            ],
          ),
        ),
      ),
    );
  }
}