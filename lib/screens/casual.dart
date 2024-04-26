import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/flag.dart';
import '../widgets/grid_6x6.dart';
import '../widgets/level_display.dart';
import '../widgets/SquareButton.dart';

class CasualGame extends StatefulWidget {
  const CasualGame({Key? key}) : super(key: key);

  @override
  _CasualGameState createState() => _CasualGameState();
}

class _CasualGameState extends State<CasualGame> with TickerProviderStateMixin  {
  int currentPoints = 1;
  int _level = 1;
  int _points = 0;
  int difference = 0;
  bool showAdditionalButtons = false;
  late Key gridKey;
  bool button0 = false;
  bool button1 = false;
  bool button2 = false;
  bool button3 = false;

  @override
  void initState() {
    super.initState();
    gridKey = UniqueKey();
  }

  void _updateButton0(bool newValue) {
    setState(() {
      button0 = newValue;
    });
  }

  void _updateButton1(bool newValue) {
    setState(() {
      button1 = newValue;
    });
  }

  void _updateButton2(bool newValue) {
    setState(() {
      button2 = newValue;
    });
  }

  void _updateButton3(bool newValue) {
    setState(() {
      button3 = newValue;
    });
  }

  void _onLevelChange(int newLevel) {
    setState(() {
      _level = newLevel;
      difference = 0;
      currentPoints = 1;
      gridKey = UniqueKey();
    });
  }

  void _LosingGame() {
    setState(() {
      _level = 1;
      difference = 0;
      _points = 0;
      currentPoints = 1;
      gridKey = UniqueKey();
    });
  }

  void _showLevelUpDialog() {

    final animationController = AnimationController(
      duration: const Duration(seconds: 3), // Set the duration for the animation
      vsync: this,
    );

    animationController.forward();

    showDialog(
      context: context,
      barrierDismissible: true, // Allow dismissing dialog by tapping outside
      builder: (BuildContext context) {
        return FadeTransition(
          opacity: Tween<double>(
            begin: 0.0, // Start from fully transparent
            end: 1.0, // Fade in to fully opaque
          ).animate(animationController), // Use linear curve for constant speed// Use linear curve for reversing animation (optional),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black, width: 10.0,),
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Text(
              'Congratulations!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              'You completed level $_level and gained $_points points. Are you ready for the next level?',
              style: const TextStyle(fontSize: 18),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 24), // Increase font size
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      _onLevelChange(
          _level + 1); // Perform level change after dialog is dismissed
    });
  }

  void _showLosingDialog() {

    final animationController = AnimationController(
      duration: const Duration(seconds: 3), // Set the duration for the animation
      vsync: this,
    );

    animationController.forward();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return FadeTransition(
          opacity: Tween<double>(
            begin: 0.0, // Start from fully transparent
            end: 1.0, // Fade in to fully opaque
          ).animate(animationController), // Use linear curve for constant speed// Use linear curve for reversing animation (optional),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black, width: 10.0,),
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Text(
              'Unfortunate',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'You clicked on an Angry Cat',
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
                child: const Text(
                  'Play again?',
                  style: TextStyle(fontSize: 24), // Increase font size
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      _LosingGame(); // Perform level change after dialog is dismissed
    });
  }
  int randomNumber = Random().nextInt(100) + 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff52ed8f),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 10.0,),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  title: const Text('Are you sure you want to quit?',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  content: const Text('Leaving will reset the game',
                      style: TextStyle(fontSize: 20),),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: const Text('Leave',style: TextStyle(fontSize: 24),),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Stay',style: TextStyle(fontSize: 24),),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                LevelDisplay(level: _level, points: _points),
                const SizedBox(height: 25),
                Grid6x6(
                  key: gridKey,
                  level: _level,
                  randomNumber: randomNumber,
                  onSumChange: (originalSum, sum) {
                    int pointDifference = (originalSum - sum);
                    difference = difference + (originalSum - sum);
                    if (pointDifference == 2) {
                      currentPoints = currentPoints * 2;
                    } else if (pointDifference == 3) {
                      currentPoints = currentPoints * 3;
                    } else if (currentPoints == 1) {
                      currentPoints = currentPoints * 1;
                    }

                    if (sum == -1) {
                      _showLosingDialog();
                    } else if (difference == originalSum) {
                      _points += currentPoints;
                      _showLevelUpDialog();
                    }
                  },
                  button0: button0,
                  button1: button1,
                  button2: button2,
                  button3: button3,
                ),
              ],
            ),
            Positioned(
              bottom: 241, // Adjust position as needed
              left: 315, // Adjust position as needed
              right: 23, // Adjust position as needed
              child: SquareButton(
                onPressed: () {
                  setState(() {
                    showAdditionalButtons = !showAdditionalButtons;
                  });
                  if (showAdditionalButtons == false) {
                    button0 = false;
                    button1 = false;
                    button2 = false;
                    button3 = false;
                  }
                },
                size: 55.0, // Set the size of the square button
                color: Colors.grey,
                child: const Text(
                  'Open Memo',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (showAdditionalButtons) // Conditionally show the AdditionalButtons widget
              AdditionalButtons(
                showAdditionalButtons: showAdditionalButtons,
                updateButton0: _updateButton0,
                updateButton1: _updateButton1,
                updateButton2: _updateButton2,
                updateButton3: _updateButton3,
                button0: button0,
                button1: button1,
                button2: button2,
                button3: button3,
              ),
          ],
        ),
      ),
    );
  }
}
