import 'package:rep_check/views/auth/login.dart';
import 'package:rep_check/views/routes/about.dart';
import 'package:rep_check/views/routes/auto_lookup.dart';
import 'package:rep_check/views/routes/dashboard.dart';
import 'package:rep_check/views/routes/home.dart';
import 'package:rep_check/views/routes/manual_lookup.dart';
import 'package:rep_check/views/routes/rate_app.dart';
import 'package:rep_check/views/routes/refer_a_friend.dart';
import 'package:rep_check/views/routes/splash_page.dart';

Object appRoutes = {
  '/': (context) => HomePage(),
  '/auto': (context) => AutoLookupPage(),
  '/manual': (context) => ManualLookupPage(),
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
