import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

MediaQueryData _mediaQueryData;
double screenWidth;
double screenHeight;
double blockSizeHorizontal;
double blockSizeVertical;

double _safeAreaHorizontal;
double _safeAreaVertical;
double safeBlockHorizontal;
double safeBlockVertical;
double maxHeight;
double maxWidth;

const bool scaleVertical = true;
const double SCALE_FACTOR_VERTICAL = 7.9;
const double SCALE_FACTOR_HORIZONTAL = 3.33;

void initSizeConfigGlobal(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  blockSizeHorizontal = screenWidth / 100;
  blockSizeVertical = screenHeight / 100;

  _safeAreaHorizontal =
      _mediaQueryData.padding.left + _mediaQueryData.padding.right;
  _safeAreaVertical =
      _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
  safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
  safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  maxWidth = safeBlockHorizontal * 100;
  maxHeight = safeBlockVertical * 100;
}

double getSizeVerticallyScaled(double unscaledSize) {
  double scaledFactor = transformUnscaledSizeVertical(unscaledSize);
  return safeBlockVertical * scaledFactor;
}

double getWidth(double unscaledSize) {
  double scaledFactor = transformUnscaledSizeHorizontal(unscaledSize);
  return safeBlockHorizontal * scaledFactor;
}

double transformUnscaledSizeVertical(double unscaledSize) {
  return unscaledSize / SCALE_FACTOR_VERTICAL;
}

double transformUnscaledSizeHorizontal(double unscaledSize) {
  return unscaledSize / SCALE_FACTOR_HORIZONTAL;
}