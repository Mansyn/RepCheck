import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/utils/constants.dart';

class Widgethelper {
  static Widget getCivicPhoto(Official official) {
    if (official.photoUrl != null) {
      return buildProfilePhoto(official.photoUrl);
    } else {
      return Image.asset(Constants.whiteAvatar, fit: BoxFit.cover);
    }
  }

  static Widget getPublicaPhoto(member) {
    if (member.facebookAccount != null) {
      return buildProfilePhoto(
          Constants.fbPhotoUrl.replaceFirst('{id}', member.facebookAccount));
    } else if (member.twitterAccount != null) {
      return buildProfilePhoto(
          Constants.twitPhotoUrl.replaceFirst('{id}', member.twitterAccount));
    } else {
      return Image.asset(Constants.whiteAvatar, fit: BoxFit.cover);
    }
  }

  static Widget buildProfilePhoto(url) {
    return CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            SpinKitThreeBounce(
              color: Colors.white,
              size: 50.0,
            ),
        errorWidget: (context, url, error) =>
            Image.asset(Constants.whiteAvatar, fit: BoxFit.cover),
        fit: BoxFit.cover);
  }

  static String getMemberParty(member) {
    return getPartyName(member.party);
  }

  static String getPartyName(String partyInit) {
    switch (partyInit) {
      case 'R':
      case 'Republican Party':
        return 'Republican';
        break;
      case 'D':
      case 'Democratic Party':
        return 'Democrat';
        break;
      case 'L':
        return 'Libertarian';
        break;
      default:
        return partyInit;
        break;
    }
  }
}
