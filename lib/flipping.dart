import 'package:flutter/material.dart';

class FlippingButton extends StatefulWidget {
  final String imagePath;

  const FlippingButton({Key? key, required this.imagePath}) : super(key: key);

  @override
  _FlippingButtonState createState() => _FlippingButtonState();
}

class _FlippingButtonState extends State<FlippingButton> {
  bool _isFlipped = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isFlipped = !_isFlipped;
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _isFlipped ? _buildFlippedImage() : _buildUnflippedImage(),
      ),
    );
  }

  Widget _buildUnflippedImage() {
    return Ink.image(
      key: UniqueKey(),
      image: const AssetImage('images/blanktile.png'),
      height: 150,
      width: 150,
    );
  }

  Widget _buildFlippedImage() {
    print('help im being pushed');
    return RotationTransition(
      turns: const AlwaysStoppedAnimation(180 / 360),
      child: Ink.image(
        key: UniqueKey(),
        image: AssetImage(widget.imagePath),
        height: 150,
        width: 150,
      ),
    );
  }
}
