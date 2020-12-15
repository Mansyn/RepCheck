import 'package:flutter/material.dart';

List<Widget> fakeBottomButtons({double height = 50}) {
  List<Widget> fakeBottomButtons = new List<Widget>();
  fakeBottomButtons.add(new Container(
    height: height,
    color: Colors.transparent,
  ));
  return fakeBottomButtons;
}

Widget fakeBottom({double height = 50}) {
  return SizedBox(
    height: height,
  );
}
