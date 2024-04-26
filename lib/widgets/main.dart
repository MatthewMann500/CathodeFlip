import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/casual.dart';
import 'package:my_flutter_app/splash_screen.dart';

void main() {
  runApp(const SplashScreen());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(_controller);
    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: const Interval(0, 1, curve: Curves.easeInOut),
    ));

    _scaleController.forward();
    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scaleController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _scaleController
            .forward(); // Restart the animation when it reaches the start
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  // First instance of background image
                  Positioned(
                    top: MediaQuery.of(context).size.height *
                        (_animation.value.dy - 1),
                    child: Image.asset(
                      'images/cat_background (1).png',
                      fit: BoxFit.none,
                    ),
                  ),
                  // Second instance of background image
                  Positioned(
                    top: MediaQuery.of(context).size.height *
                        (_animation.value.dy),
                    child: Image.asset(
                      'images/cat_background (1).png',
                      fit: BoxFit.none,
                    ),
                  ),
                ],
              );
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset(
                            'images/Cathode_Flip_Title.png',
                            width: 450,
                            height: 450,
                          ),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CasualGame()));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>( const Color(0xFF44C87B)),
                      // Set background color
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                        elevation: MaterialStateProperty.all<double>(10.0),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.5)),
                      fixedSize: MaterialStateProperty.all(
                          const Size(250, 50)), // Set width and height
                    ),
                      child: const Center(
                        child: Text(
                          'Play',
                          style: TextStyle(
                            color: Colors.white, // Set text color
                            fontSize: 24, // Set text size
                            fontWeight: FontWeight.bold, // Set text weight
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
