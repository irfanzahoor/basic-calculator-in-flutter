import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.title,
    this.color = const Color.fromARGB(255, 216, 216, 216),
    required this.onPress,
  });

  final String title;
  final Color color;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: 69,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
