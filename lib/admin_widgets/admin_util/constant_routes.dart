import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:gymha/screens/user_side_screens/user_gallery.dart';

const String adminNewsletter = '/adminNewsletter';
const String adminCounseling = '/adminCounseling';
const String adminEditUsers = '/adminEditUsers';
const String adminViewUsers = '/adminViewUsers';
const String adminGallery = '/adminGallery';

const String userGallery = '/userGallery';

abstract class Routes {
  Routes._();

  // static const HOME = _Paths.HOME;
  // static const LOGIN = _Paths.LOGIN;
  // static const SIGN_UP = _Paths.SIGN_UP;
  // static const AUTHENTICATION = _Paths.AUTHENTICATION;
  static const adminnewsletter = _Paths.adminNewsletter;
  static const newsletterDetail = _Paths.NewsletterDetail;
  //static const PROFILE = _Paths.PROFILE;
  static const MY_BLOGS = _Paths.MY_BLOGS;
  static const FAVOURITE = _Paths.FAVOURITE;
}

abstract class _Paths {
  // static const HOME = '/home';
  // static const LOGIN = '/login';
  // static const SIGN_UP = '/sign-up';
  // static const AUTHENTICATION = '/authentication';
 // static const admin_newsletter = '/admin_newsletter';
  static const adminNewsletter = '/adminNewsletter';
  static const NewsletterDetail = '/NewsletterDetail';
 // static const PROFILE = '/profile';
  static const MY_BLOGS = '/my-blogs';
  static const FAVOURITE = '/favourite';
}