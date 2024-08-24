import 'dart:async';
import 'package:flutter/material.dart';
import 'package:merchant/ui/home/home_screen.dart';
import '../../util/size_config.dart';
import '../auth/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static var routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isUserLogged();
  }

  void isUserLogged() {
    Timer(
        const Duration(seconds: 0),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    isUserLogged();
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
            child: Image.asset(
          'assets/images/logo.png',
          width: 200,
          height: 200,
        )),
      ),
    );
  }
}
