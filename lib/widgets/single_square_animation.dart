import 'package:flutter/material.dart';

class SingleSquareAnimation extends StatefulWidget {
  final String imagePath;
  final String backCardPath;
  final List<List<int>> rowSumsZeros;
  final List<List<int>> colSumsZeros;
  final Function(int, int) onSumChange;
  final int sum;
  const SingleSquareAnimation({
    Key? key,
    required this.imagePath,
    required this.backCardPath,
    required this.rowSumsZeros,
    required this.colSumsZeros,
    required this.sum,
    required this.onSumChange,
  }) : super(key: key);

  @override
  _SingleSquareAnimationState createState() => _SingleSquareAnimationState();
}

class _SingleSquareAnimationState extends State<SingleSquareAnimation>
    with SingleTickerProviderStateMixin {

  AnimationController? _controller;
  Animation<double>? _animation;
  bool _isCardFlipVisible = true;

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
        if (widget.imagePath == 'images/blanktile.png') {
          _flipCard();
          if(_isCardFlipVisible == true) {
            _updateSum();
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        child: Transform(
          transform: Matrix4.rotationY(
              _isCardFlipVisible ? _animation!.value * 3.14 : 0),
          alignment: Alignment.center,
          child: SizedBox(
            width: 55,
            height: 55,
            child: _isCardFlipVisible ? _buildBack() : _buildFront(),
          ),
        ),
      ),
    );
  }

  Widget _buildFront() {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 3),
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
          border: Border.all(color: Colors.blueGrey, width: 3),
        ),
        child: Center(
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.cover,
            width: 55,
            height: 55,
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
    }
    else if (widget.backCardPath == 'images/numberTile3.png')
      {
        newSum = -1;
      }
    newSum -= originalValue;
    widget.onSumChange(originalSum, newSum);
  }
}
