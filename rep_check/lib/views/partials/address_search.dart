import 'package:flutter/material.dart';
import 'package:rep_check/repositories/places_repository.dart';
import 'package:rep_check/responses/maps/suggestion_response.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';

class AddressSearch extends SearchDelegate<SuggestionResponse> {
  AddressSearch(this.sessionToken) {
    placesRepository = PlaceRepository(sessionToken);
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
  PlaceRepository placesRepository;

  final Map<String, String> favoriteLocationImage = {
    'street_address': 'assets/images/locations/house.png',
    'establishment': 'assets/images/locations/store.png',
    'food': 'assets/images/locations/store.png',
    'finance': 'assets/images/locations/bank.png',
    'place_of_worship': 'assets/images/locations/church.png',
    'neighborhood': 'assets/images/locations/premise.png',
    'premise': 'assets/images/locations/premise.png',
    'subpremise': 'assets/images/locations/premise.png'
  };

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

  ListTile buildTile(BuildContext context, dynamic data) {
    SuggestionResponse response = data as SuggestionResponse;

    String locationImage =
        ((response.types != null && response.types.first != null)
                ? favoriteLocationImage[response.types.first]
                : favoriteLocationImage['street_address']) ??
            favoriteLocationImage[0];

    return ListTile(
        title: Text(response.description
            .substring(0, response.description.indexOf(','))),
        subtitle: Text((response.description.substring(
                response.description.indexOf(',') + 1,
                response.description.length))
            .trim()),
        leading: CircleAvatar(
            radius: 20.0,
            backgroundColor: Styles.accentVarColor,
            child: Image.asset(locationImage,
                height: 20, width: 20, fit: BoxFit.cover)),
        onTap: () {
          close(context, response);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: query == ''
            ? null
            : placesRepository.fetchSuggestions(
                query, Localizations.localeOf(context).languageCode),
        builder: (context, snapshot) => query == ''
            ? Container(
                padding: EdgeInsets.all(Constants.commonPadding),
                child: Text('enter an address ' +
                    String.fromCharCodes(Runes('\u261D'))))
            : snapshot.connectionState == ConnectionState.done
                ? ListView.builder(
                    itemBuilder: (context, index) =>
                        buildTile(context, snapshot.data[index]),
                    itemCount: snapshot.data.length,
                  )
                : Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ));
  }
}
