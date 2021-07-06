import 'dart:math';

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get lowValueHeight => height * 0.01;
  double get normalValueHeight => height * 0.02;
  double get mediumValueHeight => height * 0.04;
  double get highValueHeight => height * 0.1;
  double get ultraHighValueHeight => height * 0.25;

  double get lowValueWidth => width * 0.01;
  double get normalValueWidth => width * 0.02;
  double get mediumValueWidth => width * 0.04;
  double get highValueWidth => width * 0.1;
  double get ultraHighValueWidth => width * 0.25;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValueHeight);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValueHeight);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValueHeight);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValueHeight);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical =>
      EdgeInsets.symmetric(vertical: lowValueHeight);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValueHeight);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValueHeight);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValueHeight);
  EdgeInsets get paddingUltraHighVertical =>
      EdgeInsets.symmetric(vertical: ultraHighValueHeight);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValueHeight);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValueHeight);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValueHeight);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValueHeight);
  EdgeInsets get paddingUltraHighHorizontal =>
      EdgeInsets.symmetric(horizontal: ultraHighValueHeight);
}

extension PageExtension on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension DurationExtension on BuildContext {
  Duration get lowDuration => Duration(milliseconds: 500);
  Duration get normalDuration => Duration(seconds: 1);
}
