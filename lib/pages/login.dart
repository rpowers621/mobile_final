import 'package:mobile_final/pages/register.dart';
import 'package:mobile_final/pages/signinemailpassword.dart';
import 'package:mobile_final/authentication.dart';
import 'package:flutter/material.dart';




class Login extends StatefulWidget {
  const Login({Key? key}): super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>{


  @override
  Widget build(BuildContext context){
    final emailPassword = OutlinedButton(
        onPressed: (){
          Navigator.push(
              context,MaterialPageRoute(builder: (con) => SignInEmailPassword()));
        },
        child: const Text("Sign in with email and password",
            style: TextStyle(
                color: Colors.amberAccent)));
    final signup = OutlinedButton(
        onPressed: (){
          Navigator.push(
              context,MaterialPageRoute(builder: (con) => const RegisterPage()));
        },
        child: const Text('Sign Up',
            style: TextStyle(
                color: Colors.amberAccent)
        ));
    final google = OutlinedButton.icon(
        icon: Image.asset('assets/googleicon.png', height: 20, width: 20,),
        label: const Text("Sign in With Google",
            style: TextStyle(
                color: Colors.amberAccent)),
        onPressed: (){
          Authentication().signInWithGoogle(context);
        } );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.teal,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                    child: Column(
                      children: <Widget> [
                        emailPassword,
                        google,
                        signup,
                      ],
                    )
                ),
              ]
          )
      ),
    );
  }
}
