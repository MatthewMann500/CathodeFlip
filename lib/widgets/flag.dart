import 'package:flutter/material.dart';
import 'SquareButton.dart';

class AdditionalButtons extends StatefulWidget {
  final bool? showAdditionalButtons;
  final void Function(bool) updateButton0;
  final void Function(bool) updateButton1;
  final void Function(bool) updateButton2;
  final void Function(bool) updateButton3;
  bool button0;
  bool button1;
  bool button2;
  bool button3; // Make showAdditionalButtons nullable
   AdditionalButtons(
      {Key? key,
        this.showAdditionalButtons = false,
        required this.updateButton0,
        required this.updateButton1,
        required this.updateButton2,
        required this.updateButton3,
        required this.button0,
        required this.button1,
        required this.button2,
        required this.button3,
      })
      : super(key: key);

  @override
  _AdditionalButtonsState createState() => _AdditionalButtonsState();
}
class _AdditionalButtonsState extends State<AdditionalButtons> {

  bool catPressed = false;
  bool onePressed = false;
  bool twoPressed = false;
  bool threePressed = false;

  @override
  Widget build(BuildContext context) {
    final bool showButtons = widget.showAdditionalButtons ?? false;
    return showButtons
        ? Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareButton(
                  onPressed: () {
                    widget.updateButton0(!widget.button0);
                    catPressed = !catPressed;
                  },
                  color: catPressed ? Colors.green : Colors.blue,
                  child: Image.asset(
                    'images/Cat_Cat.png', // Replace 'your_image.png' with the path to your image asset
                    width: 35, // Set the width of the image
                    height: 35, // Set the height of the image
                  ),
                ),
                const SizedBox(width: 10),
                SquareButton(
                  onPressed: () {
                    widget.updateButton1(!widget.button1);
                    onePressed = !onePressed;
                  },
                  color: onePressed ? Colors.green : Colors.blue,
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0, // Set the font size to make it larger
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SquareButton(
                  onPressed: () {
                    widget.updateButton2(!widget.button2);
                    twoPressed = !twoPressed;
                  },
                  color: twoPressed ? Colors.green : Colors.blue,
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0, // Set the font size to make it larger
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SquareButton(
                  onPressed: () {
                    widget.updateButton3(!widget.button3);
                    threePressed = !threePressed;
                  },
                  color: threePressed ? Colors.green : Colors.blue,
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0, // Set the font size to make it larger
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox(); // Return an empty SizedBox when additional buttons are hidden
  }
}
