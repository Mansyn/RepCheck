import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rep_check/utils/styles.dart';

import 'active-tab.dart';

class BottomBar extends StatefulWidget {
  Function callback;

  BottomBar({Key? key, required this.callback}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _controller;
  int _currentActiveTab = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 16, bottom: 5, top: 10, left: 16),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildTab('All', FontAwesomeIcons.flagUsa, 0),
              _buildTab('Federal', FontAwesomeIcons.landmark, 1),
              _buildTab('State', FontAwesomeIcons.building, 2)
            ]));
  }

  Widget _buildTab(String text, IconData icon, int index) {
    return _currentActiveTab == index
        ? ActiveTab(
            animation: _animation, key: Key(text), text: text, icon: icon)
        : Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                  setState(() {
                    _currentActiveTab = index;
                    _controller.reset();
                    _controller.forward();
                  });
                  this.widget.callback(index);
                },
                child: Icon(icon, size: 35, color: Styles.accentColor)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
