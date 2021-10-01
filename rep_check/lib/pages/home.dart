import 'package:flutter/material.dart';
import 'package:rep_check/components/main-content.dart';
import 'package:rep_check/components/top-bar.dart';
import 'package:rep_check/utils/styles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        backgroundColor: Styles.backgroundColor,
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            ExactAssetImage('assets/images/cardstock6.jpg'))),
                child: Column(children: [
                  isPortrait ? TopBar() : Row(),
                  MainContent(isPortrait: isPortrait)
                ]))));
  }
}
