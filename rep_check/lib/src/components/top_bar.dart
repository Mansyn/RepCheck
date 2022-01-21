import 'package:flutter/material.dart';
import 'package:rep_check/src/utils/styles.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  'Rep Check',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: Styles.accentColor),
                                ))
                          ])),
                  Expanded(
                      flex: 1,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset('assets/images/flag_color.png')
                          ]))
                ])));
  }
}
