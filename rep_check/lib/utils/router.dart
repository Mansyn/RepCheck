import 'package:rep_check/views/auth/login.dart';
import 'package:rep_check/views/pages/about.dart';
import 'package:rep_check/views/pages/dashboard.dart';
import 'package:rep_check/views/pages/home.dart';
import 'package:rep_check/views/pages/rate_app.dart';
import 'package:rep_check/views/pages/refer_a_friend.dart';
import 'package:rep_check/views/pages/splash_page.dart';

Object appRoutes = {
  '/': (context) => HomePage(),
//  '/auth': (context) => Router(),

// pages
  '/splash': (context) => SplashScreenPage(),
  '/refer-a-friend': (context) => ReferAFriendPage(),
  '/about': (context) => AboutPage(),
  '/rate-app': (context) => RateApp(),

  // auth
  '/login': (context) => LoginPage(),
  '/dashboard': (context) => DashboardPage(),

  // backend
};
