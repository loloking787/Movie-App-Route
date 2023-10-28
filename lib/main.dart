import 'dart:io';

import 'package:flutflix/provider/favorite_provider.dart';
import 'package:flutflix/screens/favorite_screen.dart';
import 'package:flutflix/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colors.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.primaryColor,
          useMaterial3: true,
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName : (context) => HomeScreen(),
          FavoriteScreen.routeName : (context) => FavoriteScreen(),
        },
      ),
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context) ..badCertificateCallback =
    (X509Certificate cert,String host,int port) => true ;
  }
}