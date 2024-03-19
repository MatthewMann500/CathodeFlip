import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.greenAccent,
        useMaterial3: true,
      ),
      home: const SplashScreenState(),
    );
  }
}

class SplashScreenState extends StatelessWidget {
  const SplashScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    _navigateToNextScreen(context);
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('images/intel.jpg', width: 200, height: 200),
          const SizedBox(height: 20),
          const CircularProgressIndicator(),
        ]),
      ),
    );
  }

  Future<void> _navigateToNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MyHomePage(
            title: 'SOmething'), // Replace with your desired screen
      ),
    );
  }
}
