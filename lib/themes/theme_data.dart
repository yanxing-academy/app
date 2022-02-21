import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YanxingThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static const yanxingBlue1 = Color(0xFFECF5FF);
  static const yanxingBlue2 = Color(0xFFD9ECFF);
  static const yanxingBlue3 = Color(0xFFC6E2FF);
  static const yanxingBlue4 = Color(0xFFB3D8FF);
  static const yanxingBlue5 = Color(0xFFA0CFFF);
  static const yanxingBlue6 = Color(0xFF8CC5FF);
  static const yanxingBlue7 = Color(0xFF79BBFF);
  static const yanxingBlue8 = Color(0xFF66B1FF);
  static const yanxingBlue9 = Color(0xFF53A8FF);
  static const yanxingBlue10 = Color(0xFF409EFF);
  static const yanxingBlue11 = Color(0xFF2D94FF);
  static const yanxingBlue12 = Color(0xFF238FFF);
  static const yanxingBlue13 = Color(0xFF1689FF);
  static const yanxingBlue20 = Color(0xFF007DFF);

  static const navColor = yanxingBlue3;

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        // backgroundColor: colorScheme.background,
        backgroundColor: navColor,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        titleTextStyle: TextStyle(color: colorScheme.primary, fontSize: 16),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1?.apply(color: _darkFillColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
      )),
      navigationRailTheme: const NavigationRailThemeData().copyWith(
        backgroundColor: YanxingThemeData.yanxingBlue4,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
        backgroundColor: navColor,
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Colors.blue,
    primaryContainer: Color(0xFF117378),
    secondary: Color(0xFFEFF3F3),
    secondaryContainer: Color(0xFFFAFBFB),
    // background: Color(0xFFE6EBEB),
    background: YanxingThemeData.yanxingBlue1,
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryContainer: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryContainer: Color(0xFF451B6F),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF), // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline3: GoogleFonts.liuJianMaoCao(
        fontWeight: _bold, fontSize: 28.0, color: Colors.black),
    headline4: GoogleFonts.zcoolXiaoWei(
        fontWeight: _bold, fontSize: 20.0, color: Colors.black),
    headline5: GoogleFonts.notoSerif(fontWeight: _medium, fontSize: 16.0),
    headline6: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
    caption: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
    subtitle1: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
    overline: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
    bodyText1: GoogleFonts.roboto(fontWeight: _regular, fontSize: 14.0),
    subtitle2: GoogleFonts.roboto(fontWeight: _medium, fontSize: 14.0),
    bodyText2: GoogleFonts.roboto(fontWeight: _regular, fontSize: 16.0),
    button: GoogleFonts.roboto(fontWeight: _semiBold, fontSize: 14.0),
  );
}
