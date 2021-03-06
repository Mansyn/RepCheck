import 'package:flutter/material.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeaderItem(),
      AutoItem(),
      Divider(
        color: Styles.accentColor,
      ),
      ManualItem(),
      Divider(
        color: Styles.accentColor,
      ),
      ReferAFriendItem(),
      Divider(
        color: Styles.accentColor,
      ),
      AboutItem(),
      SizedBox(
        height: 50,
      )
    ]));
  }
}

class BackendDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeaderItem(),
          LogoutItem(),
          AboutItem(),
          ReferAFriendItem(),
          RateAppItem(),
          HomeItem(),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

/// menu header
class DrawerHeaderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(Constants.backgroundHeaderKey))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Rep Check",
                  style: Styles.h1AppBar.copyWith(fontSize: 40.0, shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Styles.accentColor,
                      offset: Offset(4.0, 4.0),
                    ),
                  ]))),
        ]));
  }
}

/// home item
class HomeItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Home"),
      leading: Icon(Icons.lightbulb_outline),
      onTap: () {
        Navigator.pop(context);

        Navigator.pushNamed(context, '/');
      },
    );
  }
}

class AutoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Detect District"),
      leading: Icon(Icons.location_searching),
      onTap: () {
        Navigator.pushNamed(context, '/auto');
      },
    );
  }
}

class ManualItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Lookup District"),
      leading: Icon(Icons.search),
      onTap: () {
        Navigator.pushNamed(context, '/manual');
      },
    );
  }
}

/// refer a friend item
class ReferAFriendItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Refer a Friend"),
      leading: Icon(Icons.share),
      onTap: () {
        Navigator.pop(context);

        Navigator.pushNamed(context, '/refer-a-friend');
      },
    );
  }
}

/// logout item
class LogoutItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Logout"),
      leading: Icon(Icons.exit_to_app),
      onTap: () {
//        AuthProvider().logout();

//        Navigator.pop(context);
//        Navigator.pop(context);

        Navigator.pushNamed(context, '/');
      },
    );
  }
}

/// login item
class LoginItem extends StatefulWidget {
  @override
  _LoginItemState createState() => _LoginItemState();
}

class _LoginItemState extends State<LoginItem> {
  bool loggedIn = false;

  void _checkStatus() async {
//    bool isLoggedIn = await AuthProvider().checkIfAuth();
//    setState(() {
//      loggedIn = isLoggedIn;
//    });
  }

  @override
  void initState() {
    _checkStatus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loggedIn
        ? ListTile(
            title: Text("Dashboard"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);

              Navigator.pushNamed(context, '/dashboard');
            },
          )
        : ListTile(
            title: Text("Sign In"),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.pop(context);

              Navigator.pushNamed(context, '/login');
            },
          );
  }
}

/// about item
class AboutItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("About"),
      leading: Icon(Icons.info_outline),
      onTap: () {
        Navigator.pop(context);

        Navigator.pushNamed(context, '/about');
      },
    );
  }
}

/// rate app item
class RateAppItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Rate Us"),
      leading: Icon(Icons.star),
      onTap: () {
        Navigator.pop(context);

        Navigator.pushNamed(context, '/rate-app');
      },
    );
  }
}
