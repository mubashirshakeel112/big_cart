import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/presentation/dashboard/dashboard_view.dart';
import 'package:big_cart/presentation/home/home_view.dart';
import 'package:big_cart/presentation/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashView extends StatefulWidget {
  static const String id = '/splash_view';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      if(context.mounted) Navigator.pushReplacementNamed(context, checkUser());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(Strings.splash, fit: BoxFit.cover,),
          ),
          Positioned(
            top: 76,
            left: 47,
            right: 47,
            child: Column(
              children: [
                Text('Welcome to', style: interBold.copyWith(fontSize: 30),),
                Image.asset(Strings.bigCart, height: 50, fit: BoxFit.contain,),
                SizedBox(height: 17,),
                Text('Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy', textAlign: TextAlign.center, style: interMedium)
              ],
            ),
          )
        ],
      ),
    );
  }

  String checkUser(){
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return HomeView.id;
    }else{
      return LoginView.id;
    }
  }
}
