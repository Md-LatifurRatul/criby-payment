import 'package:flutter/widgets.dart';

class AppThemeTextStyles {
  static const _satoshiFont = 'Satoshi';
  static const _plusJakartaFonts = 'PlusJakarta';

  static const appHeaderSection = TextStyle(
    fontFamily: _satoshiFont,
    fontWeight: FontWeight.w900,
    fontSize: 22.91,
    color: Color(0xFF2D2D2D),
    height: 1,
    letterSpacing: 0,
  );

  static const bodyHeaderBold = TextStyle(
    fontFamily: _plusJakartaFonts,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1,
    letterSpacing: 0,
    color: Color(0xFF0C0310),
  );

  static const bodySectionSemiBold = TextStyle(
    fontFamily: _plusJakartaFonts,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 22 / 16,
    letterSpacing: 0,
    color: Color(0xFF0C0310),
  );

  static const bodySectionMedium = TextStyle(
    fontFamily: _plusJakartaFonts,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 16,
    letterSpacing: 0,
    color: Color(0xFF0C0310),
  );
}
