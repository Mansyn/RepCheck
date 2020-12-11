import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rep_check/models/member.dart';
import 'package:rep_check/utils/constants.dart';

class Widgethelper {
  static Widget getProfilePhoto(member) {
    if (member.facebookAccount != null) {
      return CachedNetworkImage(
          imageUrl:
              Constants.fbPhotoUrl.replaceFirst('{id}', member.facebookAccount),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover);
    } else {
      return Image.asset(Constants.defaultProfile, fit: BoxFit.cover);
    }
  }

  static String getMemberParty(Member member) {
    return getPartyName(member.party);
  }

  static String getPartyName(String partyInit) {
    switch (partyInit) {
      case 'R':
        return 'Republican';
        break;
      case 'D':
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
