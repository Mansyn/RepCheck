import 'package:flutter/material.dart';
import 'package:rep_check/repositories/places_repository.dart';
import 'package:rep_check/responses/maps/suggestion_response.dart';
import 'package:rep_check/utils/styles.dart';

class AddressSearch extends SearchDelegate<SuggestionResponse> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    var theme = Theme.of(context);
    if (theme.brightness == Brightness.light) {
      return theme;
    }

    return theme.copyWith(
      primaryColor: Styles.primaryColor,
    );
  }

  final sessionToken;
  PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: query == ""
            ? null
            : apiClient.fetchSuggestions(
                query, Localizations.localeOf(context).languageCode),
        builder: (context, snapshot) => query == ''
            ? Container(
                padding: EdgeInsets.all(16.0),
                child: Text('Enter the address'),
              )
            : snapshot.hasData
                ? ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      title: Text((snapshot.data[index] as SuggestionResponse)
                          .description),
                      onTap: () {
                        close(context,
                            snapshot.data[index] as SuggestionResponse);
                      },
                    ),
                    itemCount: snapshot.data.length,
                  )
                : Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Loading...'),
                  ));
  }
}
