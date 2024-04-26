import 'package:flutter/material.dart';

class SingleSquareAnimation extends StatefulWidget {
  final String imagePath;
  final String backCardPath;
  final List<List<int>> rowSumsZeros;
  final List<List<int>> colSumsZeros;
  final Function(int, int) onSumChange;
  final int sum;
  bool shouldDisplaySquares;
  bool button1;
  bool button2;
  bool button3;
  bool button0;

  SingleSquareAnimation({
    Key? key,
    required this.imagePath,
    required this.backCardPath,
    required this.rowSumsZeros,
    required this.colSumsZeros,
    required this.sum,
    required this.onSumChange,
    required this.shouldDisplaySquares,
    required this.button1,
    required this.button2,
    required this.button3,
    required this.button0,
  }) : super(key: key);

  @override
  _SingleSquareAnimationState createState() => _SingleSquareAnimationState();
}

class _SingleSquareAnimationState extends State<SingleSquareAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  bool _isCardFlipVisible = true;
  bool showCat = false;
  bool showOnes = false;
  bool showTwos = false;
  bool showThrees = false;
  bool buttonsOn = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_isCardFlipVisible) {

      setState(() {
        showCat = false;
        showOnes = false;
        showTwos = false;
        showThrees = false;
      });

      _controller!.forward().then((_) {
        setState(() {
          _isCardFlipVisible = false;
        });
      });
    } else {
      _controller!.reverse().then((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.button0 == true ||
            widget.button1 == true ||
            widget.button2 == true ||
            widget.button3 == true) {
          buttonsOn = true;
        } else {
          buttonsOn = false;
        }
        if (widget.imagePath == 'images/blanktile.png' &&
            widget.backCardPath != 'test' &&
            buttonsOn == false) {
          _flipCard();
          if (_isCardFlipVisible == true) {
            _updateSum();
          }
        }
        if (widget.backCardPath == 'test') {
          setState(() {
            widget.shouldDisplaySquares = !widget.shouldDisplaySquares;
          });
        }

        if (widget.button0 == true &&
            _isCardFlipVisible == true) {
          setState(() {
            showCat = !showCat;
          });
        }
        if (widget.button1 == true &&
            _isCardFlipVisible == true) {
          setState(() {
            showOnes = !showOnes;
          });
        }
        if (widget.button2 == true &&
            _isCardFlipVisible == true) {
          setState(() {
            showTwos = !showTwos;
          });
        }
        if (widget.button3 == true &&
            _isCardFlipVisible == true) {
          setState(() {
            showThrees = !showThrees;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        child: Stack(
          children: [
            Transform(
              transform: Matrix4.rotationY(
                  _isCardFlipVisible ? _animation!.value * 3.14 : 0),
              alignment: Alignment.center,
              child: SizedBox(
                width: 55,
                height: 55,
                child: _isCardFlipVisible ? _buildBack() : _buildFront(),
              ),
            ),
            if (showCat) // Conditionally show the text
              Positioned(
                left: 5,
                child: Center(
                  child: Image.asset(
                    'images/Cat_Cat.png', // Provide the path to your image asset
                    width: 20, // Adjust width as needed
                    height: 20, // Adjust height as needed
                    fit: BoxFit.contain, // Adjust the fit of the image
                  ),
                ),
              ),
            if (showOnes) // Conditionally show the text
              const Positioned(
                right: 5,
                child: Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            if (showTwos) // Conditionally show the text
              const Positioned(
                left: 5,
                bottom: 0,
                child: Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            if (showThrees) // Conditionally show the text
              const Positioned(
                right: 5,
                bottom: 0,
                child: Center(
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFront() {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 5),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Image.asset(
          widget.backCardPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBack() {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.blueGrey, width: 5),
        ),
        child: Center(
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.cover,
            width: 60,
            height: 60,
          ),
        ),
      ),
    );
  }

  void _updateSum() {
    int newSum = widget.sum;
    int originalSum = widget.sum;
    int originalValue = 0;
    if (widget.backCardPath == 'images/numberTile1.png') {
      originalValue = 2;
    } else if (widget.backCardPath == 'images/numberTile2.png') {
      originalValue = 3;
    } else if (widget.backCardPath == 'images/numberTile3.png') {
      newSum = -1;
    }
    newSum -= originalValue;
    widget.onSumChange(originalSum, newSum);
  }
}
