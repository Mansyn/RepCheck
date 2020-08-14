import 'package:flutter/material.dart';
import 'package:rep_check/data/bloc/member_bloc.dart';
import 'package:rep_check/data/model/member.dart';
import 'package:rep_check/data/network/response.dart';
import 'package:rep_check/state/shared_state.dart';

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
    _bloc = MemberBloc(widget.state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Congress Members',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF333333),
      ),
      backgroundColor: Color(0xFF333333),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchMembers(),
        child: StreamBuilder<Response<MemberResponse>>(
          stream: _bloc.memberListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
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
  final MemberResponse categoryList;

  const CategoryList({Key key, this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF202020),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 1.0,
              ),
              child: InkWell(
                  child: SizedBox(
                height: 65,
                child: Container(
                  color: Color(0xFF333333),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Text(
                      categoryList.results[index].name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Roboto'),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              )));
        },
        itemCount: categoryList.results.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
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
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
