import 'package:flutter/material.dart';
import 'package:rep_check/src/components/main_content.dart';
import 'package:rep_check/src/components/top_bar.dart';
import 'package:rep_check/src/utils/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        backgroundColor: Styles.backgroundColor,
        body: SafeArea(
            child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            ExactAssetImage('assets/images/cardstock6.jpg'))),
                child: Column(children: [
                  isPortrait ? const TopBar() : Row(),
                  MainContent(isPortrait: isPortrait)
                ]))));
  }
}
