import 'dart:math';

import 'package:flutter/material.dart';

class SpeedGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speed Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Grid6x6(),
            SizedBox(height: 20),
            Text(
              'Time: 00:00:00', // Add your text here
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ), // Add the Grid6x6 widget here
          ],
        ),
      ),
    );
  }
}

class Grid6x6 extends StatelessWidget {
  final levels = {
    "1": [
      [5, 0, 6],
      [4, 1, 6],
      [3, 1, 6],
      [2, 2, 6],
      [0, 3, 6]
    ],
    "2": [
      [6, 0, 7],
      [5, 1, 7],
      [3, 2, 7],
      [1, 3, 7],
      [0, 4, 7]
    ],
    "3": [
      [7, 0, 8],
      [6, 1, 8],
      [4, 2, 8],
      [2, 3, 8],
      [1, 4, 8]
    ],
    "4": [
      [8, 0, 10],
      [5, 2, 10],
      [3, 3, 8],
      [2, 4, 10],
      [0, 5, 8]
    ],
    "5": [
      [9, 0, 10],
      [7, 1, 10],
      [6, 2, 10],
      [4, 3, 10],
      [1, 5, 10]
    ],
    "6": [
      [8, 1, 10],
      [5, 3, 10],
      [3, 4, 10],
      [2, 5, 10],
      [0, 6, 10]
    ],
    "7": [
      [9, 1, 13],
      [7, 2, 10],
      [6, 3, 10],
      [4, 4, 10],
      [1, 6, 13]
    ],
  };
  final Set<int> boardType = Set();
  final Set<Point<int>> generatedPoints = {};

  Point<int> generateUniquePoint(int maxX, int maxY) {
    Random random = Random();
    while (true) {
      int x = random.nextInt(maxX);
      int y = random.nextInt(maxY);
      Point<int> newPoint = Point(x, y);
      if (!generatedPoints.contains(newPoint)) {
        generatedPoints.add(newPoint);
        return newPoint;
      }
    }
  }

  int testCount = -1;
  int testCount2 = 0;
  @override
  Widget build(BuildContext context) {
    boardType.add(Random().nextInt(5));
    int specifics = boardType.first;
    List<List<int>> rowSumsZeros = List.generate(5, (_) => [0, 0]);
    List<List<int>> colSumsZeros = List.generate(5, (_) => [0, 0]);
    List<List<int>> sublist = levels["1"]!;
    List<int> testList = levels["1"]?[specifics] ?? [];
    int number = sublist[specifics].reduce((value, element) => value + element);

    for (int i = 0; i < number; ++i) {
      Point<int> point = generateUniquePoint(5, 5);
      print(point);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (colIndex) {
            String imagePath = '';
            String backCardPath = '';
            if (colIndex == 5) {
              switch (rowIndex) {
                case 0:
                  imagePath = 'images/numTile0.png';
                  break;
                case 1:
                  imagePath = 'images/numTile1.png';
                  break;
                case 2:
                  imagePath = 'images/numTile2.png';
                  break;
                case 3:
                  imagePath = 'images/numTile3.png';
                  break;
                case 4:
                  imagePath = 'images/numTile4.png';
                  break;
                case 5:
                  imagePath = 'images/blanktile.png';
                  break;
              }
            } else if (rowIndex == 5) {
              switch (colIndex) {
                case 0:
                  imagePath = 'images/numTile0.png';
                  break;
                case 1:
                  imagePath = 'images/numTile1.png';
                  break;
                case 2:
                  imagePath = 'images/numTile2.png';
                  break;
                case 3:
                  imagePath = 'images/numTile3.png';
                  break;
                case 4:
                  imagePath = 'images/numTile4.png';
                  break;
                case 5:
                  imagePath =
                      'images/numTile0.png'; // use this to sum up the rows/ columns
                  break;
              }
            } else {
              imagePath = 'images/blanktile.png';
              if (generatedPoints.contains(Point(rowIndex, colIndex))) {
                bool testings = true;
                int randomIndex = 0;
                while (testings) {
                  randomIndex = Random().nextInt(3);
                  if (testList[randomIndex] > 0) {
                    randomIndex = randomIndex + 1;
                    backCardPath = 'images/numberTile$randomIndex.png';
                    --testList[randomIndex - 1];
                    testings = false;
                  }
                }
                switch (randomIndex - 1) {
                  case 0: // 2
                    rowSumsZeros[rowIndex][0] += 2;
                    colSumsZeros[colIndex][0] += 2;
                    break;
                  case 1: // 3
                    rowSumsZeros[rowIndex][0] += 3;
                    colSumsZeros[colIndex][0] += 3;
                    break;
                  case 2: // 0
                    rowSumsZeros[rowIndex][1] += 1;
                    colSumsZeros[colIndex][1] += 1;
                    break;
                }
              } else {
                rowSumsZeros[rowIndex][0] += 1;
                colSumsZeros[colIndex][0] += 1;
                backCardPath = 'images/numberTile0.png';
              }
            }
            print(rowSumsZeros);
            print(colSumsZeros);
            List<List<List<int>>> combinedSumsZeros = [
              rowSumsZeros,
              colSumsZeros,
            ];
            return Stack(
              children: [
                SingleSquareAnimation(
                  context: context,
                  imagePath: imagePath,
                  backCardPath: backCardPath,
                  rowSumsZeros: rowSumsZeros,
                  colSumsZeros: colSumsZeros,
                ),
                if (shouldDisplayText(rowIndex, colIndex))
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        combinedSumsZeros[testCount2][testCount].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        );
      }),
    );
  }

  bool shouldDisplayText(int rowIndex, int colIndex) {
    if (colIndex == 5 && rowIndex != 5) {
      testCount++;
      return true;
    } else if (rowIndex == 5 && colIndex == 0) {
      testCount = 0;
      testCount2 = 1;
      return true;
    } else if (rowIndex == 5 && colIndex != 5) {
      testCount++;
      return true;
    }
    return false;
  }
}

class SingleSquareAnimation extends StatefulWidget {
  final BuildContext context; // Add context here
  final String imagePath;
  final String backCardPath;
  final List<List<int>> rowSumsZeros;
  final List<List<int>> colSumsZeros;
  const SingleSquareAnimation({
    Key? key,
    required this.context,
    required this.imagePath,
    required this.backCardPath,
    required this.rowSumsZeros,
    required this.colSumsZeros,
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
      duration: Duration(milliseconds: 200),
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
}
