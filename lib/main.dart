import 'package:flutter/material.dart';
import 'screens/SplashScreen.dart';
void main() {
  runApp( MyApp());
}

class MyApp  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    home: SplashScreen(),
      debugShowCheckedModeBanner: false,

    );

  }
}



