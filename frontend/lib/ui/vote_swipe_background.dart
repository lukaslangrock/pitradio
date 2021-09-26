import 'package:flutter/material.dart';

class VoteSwipeBackground extends StatelessWidget {
  const VoteSwipeBackground({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    required this.direction,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color color;
  final bool direction;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment:
              direction ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
