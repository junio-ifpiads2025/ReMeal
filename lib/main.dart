import 'package:flutter/material.dart';
import 'package:remeal/navigation/bottom_navigation.dart';
import 'package:remeal/navigation/router_Generator.dart';
import 'package:remeal/pages/auth/login.dart';

void main() {
  runApp(const MyApp());
}

const isLoggedIn = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      home: isLoggedIn ? const BottomNavigation() : const Login(),
    );
  }
}