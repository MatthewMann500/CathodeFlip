import 'package:flutter/material.dart';

import '../widgets/grid_6x6.dart';
import '../widgets/level_display.dart';

class CasualGame extends StatefulWidget {
   const CasualGame({Key? key}) : super(key: key);


   @override
   _CasualGameState createState() => _CasualGameState();
}

class _CasualGameState extends State<CasualGame> {

  int _level = 1;
  int _points = 0;
  int difference = 0;
  Key _gridKey = UniqueKey();
  void _onLevelChange(int newLevel) {
    setState(() {
      _level = newLevel;
      difference = 0;
      print(_level);
      _gridKey = UniqueKey();
    });
  }

  void _LosingGame () {
    setState(() {
      _level = 1;
      difference = 0;
      _points = 0;
      _gridKey = UniqueKey();
    });
  }
  void _showLevelUpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You completed level $_level. Ready for the next level?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _onLevelChange(_level + 1);
                Navigator.of(context).pop();
              },
              child: Text('Continue'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casual Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            LevelDisplay(level: _level, points: _points),
            const SizedBox(height: 10),
            Grid6x6(
              key: _gridKey,
              level: _level,
              onSumChange: (originalSum, sum) {

                int pointDifference = (originalSum - sum);
                difference = difference + (originalSum - sum);

                if(_points == 0)
                  {
                    _points = difference * 1;
                  }
                else if(pointDifference == 2)
                  {
                    _points = _points * 2;
                  }
                else if(pointDifference == 3)
                {
                  _points = _points * 3;
                }

                if(sum == -1)
                  {
                      _LosingGame();
                  }
                else if (difference == originalSum) {
                  _showLevelUpDialog();
                }

              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}