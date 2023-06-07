import 'dart:ui';

class L10n{
  static final all =[
    const Locale ('en'),
    const Locale('ru'),
    const Locale('kk'),

  ];
  static String getFlag (String code) {
    switch (code) {
      case 'kk':
        return '🇰🇿';
      case 'ru':
        return '🇷🇺';
      case 'en':
      default:
        return '🇺🇸';
  }
  }
}