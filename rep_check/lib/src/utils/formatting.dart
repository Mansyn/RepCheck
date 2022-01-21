import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rep_check/src/data/models/civic/official.dart';
import 'package:rep_check/src/utils/styles.dart';

import 'constants.dart';

class Formatting {
  static Widget getCivicPhoto(Official official) {
    if (official.photoUrl != null) {
      return buildProfilePhoto(official.photoUrl);
    } else {
      return Container(
          decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Constants.defaultResult),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.hardLight,
          ),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ));
    }
  }

  static Widget getCivicHeadline(Official official) {
    if (official.photoUrl != null) {
      return CachedNetworkImage(
          imageUrl: official.photoUrl!,
          imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.hardLight,
                ),
              ))),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              SpinKitRing(
                color: Styles.accentColor,
                size: 50.0,
              ),
          errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                image: AssetImage(Constants.defaultResult),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.hardLight,
                ),
              ))));
    } else {
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
        image: AssetImage(Constants.defaultResult),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.2),
          BlendMode.hardLight,
        ),
      )));
    }
  }

  static Widget buildProfilePhoto(url) {
    return CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.hardLight,
                ),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            )),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            SpinKitRing(
              color: Styles.accentColor,
              size: 50.0,
            ),
        errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Constants.defaultResult),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.hardLight,
                ),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            )));
  }

  static String getMemberParty(member) {
    return getPartyName(member.party);
  }

  static String getPartyName(String partyInit) {
    switch (partyInit) {
      case 'R':
      case 'Republican Party':
        return 'Republican';
      case 'D':
      case 'Democratic Party':
        return 'Democrat';
      case 'L':
        return 'Libertarian';
      default:
        return partyInit;
    }
  }
}
