import 'package:flutter/painting.dart';

/// Primitive color scales from the Figma local variables.
///
/// Internal to `core/theme/`. Do not use in widgets: widgets use the semantic
/// tokens in [AppColors], which are defined from these values.
abstract final class AppPalette {
  // navy
  static const Color navy50 = Color(0xFFE8EDEF);
  static const Color navy100 = Color(0xFFDCE3E6);
  static const Color navy200 = Color(0xFFC2CED3);
  static const Color navy300 = Color(0xFFA7B9C0);
  static const Color navy400 = Color(0xFF8CA3AD);
  static const Color navy500 = Color(0xFF6F8C98);
  static const Color navy600 = Color(0xFF517483);
  static const Color navy700 = Color(0xFF305A6C);
  static const Color navy800 = Color(0xFF083A4F);
  static const Color navy900 = Color(0xFF062D3E);
  static const Color navy950 = Color(0xFF052736);

  // teal
  static const Color teal50 = Color(0xFFE8EFF1);
  static const Color teal100 = Color(0xFFD8E4E7);
  static const Color teal200 = Color(0xFFC0D5D6);
  static const Color teal300 = Color(0xFF94B7BF);
  static const Color teal400 = Color(0xFF6F9EA8);
  static const Color teal500 = Color(0xFF407E8C);
  static const Color teal600 = Color(0xFF37707D);
  static const Color teal700 = Color(0xFF306470);
  static const Color teal800 = Color(0xFF295964);
  static const Color teal900 = Color(0xFF224E58);
  static const Color teal950 = Color(0xFF1F4852);

  // gold
  static const Color gold50 = Color(0xFFF4F1EC);
  static const Color gold100 = Color(0xFFECE8E0);
  static const Color gold200 = Color(0xFFDDD4C5);
  static const Color gold300 = Color(0xFFCDBFA9);
  static const Color gold400 = Color(0xFFBBA98B);
  static const Color gold500 = Color(0xFFA58D66);
  static const Color gold600 = Color(0xFF907A58);
  static const Color gold700 = Color(0xFF7E6A4B);
  static const Color gold800 = Color(0xFF6D5B40);
  static const Color gold900 = Color(0xFF5C4D34);
  static const Color gold950 = Color(0xFF54452F);

  // neutral
  static const Color neutral50 = Color(0xFFF6F4F2);
  static const Color neutral100 = Color(0xFFEEEBE8);
  static const Color neutral200 = Color(0xFFE5E1DD);
  static const Color neutral300 = Color(0xFFCFCAC5);
  static const Color neutral400 = Color(0xFFA9A8A6);
  static const Color neutral500 = Color(0xFF84898B);
  static const Color neutral600 = Color(0xFF5F676B);
  static const Color neutral700 = Color(0xFF434C51);
  static const Color neutral800 = Color(0xFF2B363C);
  static const Color neutral900 = Color(0xFF17252D);
  static const Color neutral950 = Color(0xFF0C171D);

  // success
  static const Color success50 = Color(0xFFE8F1ED);
  static const Color success100 = Color(0xFFDAE8E2);
  static const Color success200 = Color(0xFFBCD5CB);
  static const Color success500 = Color(0xFF5B987D);
  static const Color success600 = Color(0xFF2F7D5B);
  static const Color success700 = Color(0xFF276B4E);
  static const Color success800 = Color(0xFF215C42);

  // warning
  static const Color warning50 = Color(0xFFF8F1E3);
  static const Color warning100 = Color(0xFFF4E7D0);
  static const Color warning200 = Color(0xFFEBD2A8);
  static const Color warning500 = Color(0xFFC9891A);
  static const Color warning600 = Color(0xFFB07716);
  static const Color warning700 = Color(0xFF9A6813);
  static const Color warning800 = Color(0xFF855A11);

  // danger
  static const Color danger50 = Color(0xFFF7EAE8);
  static const Color danger100 = Color(0xFFF1DCD9);
  static const Color danger200 = Color(0xFFE6C0BB);
  static const Color danger500 = Color(0xFFC26357);
  static const Color danger600 = Color(0xFFB23A2B);
  static const Color danger700 = Color(0xFF983124);
  static const Color danger800 = Color(0xFF82291E);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
