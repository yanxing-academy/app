class Paths {
  static const HOME = '/home';
  static const PROFILE = '/profile';
  static const STUDY = '/study';
  static const LIBRARY = '/library';
  static const VIEW_MAT = '/mat/view';
  static const VIEW_AUTHOR = '/author/view';
}

class Routes {
  static const HOME = Paths.HOME;
  static const PROFILE = Paths.HOME + Paths.PROFILE;
  static const STUDY = Paths.HOME + Paths.STUDY;
  static const LIBRARY = Paths.HOME + Paths.LIBRARY;
  static const VIEW_MAT = Paths.HOME + Paths.VIEW_MAT;
  static const VIEW_AUTHOR = Paths.HOME + Paths.VIEW_AUTHOR;

  static String VIEW_AUTHOR_DETAIL(String aid) => '$VIEW_AUTHOR/$aid';
}
