import 'dart:math';

import 'package:flutter/material.dart';
import 'single_square_animation.dart';

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
  final Function(int, int) onSumChange;
  int sum = 0;
  int level;
  Grid6x6({Key? key, required this.onSumChange, required this.level}) : super(key: key);

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
  int seed = Random().nextInt(5);
  int stopLevel = 0;
  @override
  Widget build(BuildContext context) {

    if(level > 7)
    {
        stopLevel = 7;
    }
    else {
      stopLevel = level;
    }
    List<List<int>> rowSumsZeros = List.generate(5, (_) => [0, 0]);
    List<List<int>> colSumsZeros = List.generate(5, (_) => [0, 0]);
    List<List<int>> seedList = levels[stopLevel.toString()]!;
    List<int> placeSeed = levels[stopLevel.toString()]?[seed] ?? [];
    int numberPoints = seedList[seed].reduce((value, element) => value + element);
    sum = placeSeed[0] * 2 + placeSeed[1] * 3;
    for (int i = 0; i < numberPoints; ++i) {
        generateUniquePoint(5, 5); //Randomly picks points to put 2s, 3s, 0s
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
                bool loopCheck = true;
                int randomIndex = 0;
                while (loopCheck) {
                  randomIndex = Random().nextInt(3);
                  if (placeSeed[randomIndex] > 0) {
                    randomIndex = randomIndex + 1;
                    backCardPath = 'images/numberTile$randomIndex.png';
                    --placeSeed[randomIndex - 1];
                    loopCheck = false;
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
                  imagePath: imagePath,
                  backCardPath: backCardPath,
                  rowSumsZeros: rowSumsZeros,
                  colSumsZeros: colSumsZeros,
                  sum: sum,
                  onSumChange: onSumChange,
                ),
                if (shouldDisplayText(rowIndex, colIndex))
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        combinedSumsZeros[testCount2][testCount].toString(),
                        style: const TextStyle(
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
