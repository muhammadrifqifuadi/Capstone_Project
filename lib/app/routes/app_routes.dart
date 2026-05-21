part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const PAIRING = _Paths.PAIRING;
  static const VERIFICATION = _Paths.VERIFICATION;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const FACE_RECOG = _Paths.FACE_RECOG;
  static const SECURITY = _Paths.SECURITY;
  static const PROFILE = _Paths.PROFILE;
  static const SETTINGS = _Paths.SETTINGS;
  static const SECURITY_SETTINGS = _Paths.SECURITY_SETTINGS;
  static const STATS = _Paths.STATS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const PAIRING = '/pairing';
  static const VERIFICATION = '/verification';
  static const DASHBOARD = '/dashboard';
  static const FACE_RECOG = '/face-recog';
  static const SECURITY = '/security';
  static const PROFILE = '/profile';
  static const SETTINGS = '/settings';
  static const SECURITY_SETTINGS = '/security-settings';
  static const STATS = '/stats';
}
