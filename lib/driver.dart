

import 'package:mobile_final/authentication.dart';
import 'package:mobile_final/pages/login.dart';
import 'pages/home.dart';

import 'package:flutter/material.dart';

class AppDriver extends StatelessWidget {
  AppDriver({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Authentication().getAuthUser() == null ? const Login() : HomePage();
  }
}