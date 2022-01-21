import 'package:flutter/material.dart';
import 'package:rep_check/src/utils/styles.dart';

class ActiveTab extends AnimatedWidget {
  final IconData icon;
  final String text;

  const ActiveTab(
      {Key? key,
      required Animation animation,
      required this.icon,
      required this.text})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Transform(
        transform: Matrix4.diagonal3Values(animation.value, 1, 1),
        child: Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              color: Styles.accentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(icon, color: Styles.white, size: 30),
                  Text(text,
                      style: TextStyle(color: Styles.white, fontSize: 18))
                ])));
  }
}
