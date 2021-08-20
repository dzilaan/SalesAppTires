import 'package:flutter/material.dart';
import 'package:gjkl_trading/constants.dart';
import 'package:gjkl_trading/screens/home/home_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GJKL Trading',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: inputDecorationTheme(),
      ),
      home: new SplashScreenView(
        navigateRoute: HomeScreen(),
        duration: 3000,
        imageSize: 50,
        imageSrc: "assets/images/logo.png",
        backgroundColor: Color(0xFF303A4A),
      ),
    );
  }

  InputDecorationTheme inputDecorationTheme() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Colors.white),
      gapPadding: 10,
    );
    return InputDecorationTheme(
      // if you are using latest version of flutter then label text and hint text shown like
      // if you are using flutter old  1.20.* then maybe this is not working properly
      // if we are to define our floatinglabelbehaviour in our theme then its not applayed
      // floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
    );
  }
}
