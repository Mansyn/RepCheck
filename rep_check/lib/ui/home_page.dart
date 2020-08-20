import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:rep_check/data/bloc/member_bloc.dart';
import 'package:rep_check/data/model/legislator.dart';
import 'package:rep_check/data/network/response.dart';
import 'package:rep_check/state/shared_state.dart';
import 'package:rep_check/ui/theme/colors.dart';
import 'package:rep_check/ui/theme/styles.dart';

class HomePage extends StatefulWidget {
  static const String tag = 'home-page';

  HomePage(this.state);
  final SharedState state;

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  MemberBloc _bloc;

  @override
  void initState() {
    super.initState();
    getLocation().then((location) {
      setState(() {
        widget.state.state = location.adminArea;
        widget.state.coordinates = location.coordinates;
      });
      _bloc = MemberBloc(widget.state);
    });
  }

  Future<bool> _onBackPress() {
    _askExit();
    return Future.value(false);
  }

  Future _askExit() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: new Text('Are you sure to exit app?'),
              children: <Widget>[
                new SimpleDialogOption(
                  child: new Text('OK'),
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                ),
                new SimpleDialogOption(
                  child: new Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context, 0);
                  },
                )
              ]);
        })) {
      case 1:
        exit(0);
        break;
      case 0:
        break;
    }
  }

  Future<Address> getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first; // this will return country name
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.state != null) {
      return WillPopScope(
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: primaryDarkColor,
                  title: Text(widget.state.state + ' Representatives',
                      style: primaryH1TextStyle)),
              body: _showBody()),
          //drawer: _buildDrawer()),
          onWillPop: _onBackPress);
    } else {
      return Scaffold(
          appBar: AppBar(title: Text('Your Representatives')),
          body: Loading(loadingMessage: 'determining location...'));
    }
  }

  Widget _showBody() {
    return RefreshIndicator(
      onRefresh: () => _bloc.fetchMembers(),
      child: StreamBuilder<Response<List<Legislator>>>(
        stream: _bloc.memberListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(
                    loadingMessage: 'finding your representatives...');
                break;
              case Status.COMPLETED:
                return CategoryList(categoryList: snapshot.data.data);
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => _bloc.fetchMembers(),
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class CategoryList extends StatelessWidget {
  final List<Legislator> categoryList;

  const CategoryList({Key key, this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: primaryLightColor,
      body: GroupedListView<Legislator, String>(
        groupBy: (element) => element.chamber,
        elements: categoryList,
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Container(
          color: primaryLightColor,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value.toUpperCase(),
            textAlign: TextAlign.center,
            style: primaryH1TextStyle,
          ),
        ),
        itemBuilder: (c, element) {
          return Card(
            color: primaryColor,
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Icon(Icons.account_circle),
                title: Text(element.fullName, style: primaryTextStyle),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          Center(
              child: SizedBox(
            child: const SpinKitChasingDots(color: accentColor, size: 100.0),
            height: 100.0,
            width: 100.0,
          )),
        ],
      ),
    );
  }
}
