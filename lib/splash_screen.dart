import 'package:flutter/material.dart';
import 'widgets/main.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cathode_Flip',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff52ed8f),
        useMaterial3: true,
      ),
      home: const SplashScreenState(),
    );
  }
}

class SplashScreenState extends StatefulWidget {
  const SplashScreenState({Key? key}) : super(key: key);

  @override
  State<SplashScreenState> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenState>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> _animation1;

  late AnimationController _controller2;
  late Animation<double> _animation2;

  late AnimationController _controller3;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation1 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: const Interval(0, 1, curve: Curves.easeInOut),
    ));

    _animation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: const Interval(0, 1, curve: Curves.easeInOut),
    ));

    _animation3 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller3,
      curve: const Interval(0, 1, curve: Curves.easeInOut),
    ));

    _controller1.forward();

    _controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.forward();
        _controller1.reverse();
      }
    });

    _controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller3.forward();
        _controller2.reverse();
      }
    });

    _controller3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNextScreen(context);
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 20,
                top: 265, // specify your desired top position
                child: SizedBox(
                  width: 350, // specify your desired width
                  height: 350, // specify your desired height
                  child: FadeTransition(
                    opacity: _animation1,
                    child: Image.asset(
                      'images/Cat_Cat.png',
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                right: 25,
                top: 40, // specify your desired top position
                child: SizedBox(
                  width: 550, // specify your desired width
                  height: 550, // specify your desired height
                  child: FadeTransition(
                    opacity: _animation2,
                    child: Image.asset(
                      'images/Angry_Cat.png',
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                right: 30,
                top: 150, // specify your desired top position
                child: SizedBox(
                  width: 450, // specify your desired width
                  height: 450, // specify your desired height
                  child: FadeTransition(
                    opacity: _animation3,
                    child: Image.asset(
                      'images/Explode_Cat.png',
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _navigateToNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MyHomePage(title: 'CathodeFlip'),
      ),
    );
  }
}
