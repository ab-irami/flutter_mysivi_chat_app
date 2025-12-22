import 'package:flutter/widgets.dart';

class Responsive {
  static late double _screenWidth;
  static late double _screenHeight;

  // Reference design size (you can change)
  static const double _designWidth = 390; // iPhone 12 width
  static const double _designHeight = 844; // iPhone 12 height

  static double _widthScale = 1;
  static double _heightScale = 1;
  static double _textScale = 1;

  /// Call this once in app root
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;

    _screenWidth = size.width;
    _screenHeight = size.height;

    _widthScale = _screenWidth / _designWidth;
    _heightScale = _screenHeight / _designHeight;

    // Use width-scale for text (industry standard)
    _textScale = _widthScale;
  }

  /// General scale function (based on width)
  static double scale(BuildContext context, double factor) {
    return w(factor);
  }

  /// Responsive width
  static double w(double value) => value * _widthScale;

  /// Responsive height
  static double h(double value) => value * _heightScale;

  /// Responsive text
  static double sp(double value) => value * _textScale;

  /// Responsive radius
  static double r(double value) => value * _textScale;

  /// Responsive padding
  static EdgeInsets pad({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
    left: w(left),
    right: w(right),
    top: h(top),
    bottom: h(bottom),
  );

  /// Responsive directional padding (start/end)
  static EdgeInsetsDirectional padDirectional({
    double start = 0,
    double end = 0,
    double top = 0,
    double bottom = 0,
  }) => EdgeInsetsDirectional.only(
    start: w(start),
    end: w(end),
    top: h(top),
    bottom: h(bottom),
  );

  /// Responsive symmetric padding
  static EdgeInsets padSymmetric({
    double vertical = 0,
    double horizontal = 0,
  }) => EdgeInsets.symmetric(horizontal: w(horizontal), vertical: h(vertical));

  /// Responsive all padding
  static EdgeInsets padAll(double value) => EdgeInsets.all(r(value));

  /// Responsive margin (same pattern as padding)
  static EdgeInsets mar({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
    left: w(left),
    right: w(right),
    top: h(top),
    bottom: h(bottom),
  );

  static EdgeInsets marSymmetric({
    double vertical = 0,
    double horizontal = 0,
  }) => EdgeInsets.symmetric(horizontal: w(horizontal), vertical: h(vertical));

  /// Responsive directional margin (start/end)
  static EdgeInsetsDirectional marDirectional({
    double start = 0,
    double end = 0,
    double top = 0,
    double bottom = 0,
  }) => EdgeInsetsDirectional.only(
    start: w(start),
    end: w(end),
    top: h(top),
    bottom: h(bottom),
  );

  static EdgeInsets marAll(double value) => EdgeInsets.all(r(value));
}
