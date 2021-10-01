import 'package:flutter/material.dart';
import 'package:rep_check/utils/styles.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
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
                    ]))));
  }
}
