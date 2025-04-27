import 'package:flutter/material.dart';

abstract class AppStyle {
  static TextStyle styleBold17(BuildContext context) {
    return TextStyle(
      color: const Color(0xFFFAFAFA),
      fontSize: getResponsiveFontSize(context, fontSize: 17),
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold12(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF5C5858),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold14(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF5C5858),
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF5C5858),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold25(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF232323),
      fontSize: getResponsiveFontSize(context, fontSize: 25),
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold30(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF232323),
      fontSize: getResponsiveFontSize(context, fontSize: 30),
      fontFamily: 'Inter',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle styleBold35(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF232323),
      fontSize: getResponsiveFontSize(context, fontSize: 35),
      fontFamily: 'Jura',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle styleRegular18(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF232323),
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleRegular15(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF232323),
      fontSize: getResponsiveFontSize(context, fontSize: 15),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleRegular12(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF232323),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleSemiBold16(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF5C5858),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold20(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF232323),
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleSemiBold25(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF232323),
      fontSize: getResponsiveFontSize(context, fontSize: 25),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleSemiBold30(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF232323),
      fontSize: getResponsiveFontSize(context, fontSize: 30),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleRegular25(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF5C5858),
      fontSize: getResponsiveFontSize(context, fontSize: 25),
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleRegular25W(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontSize: getResponsiveFontSize(context, fontSize: 25),
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleRegular40(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF5C5858),
      fontSize: getResponsiveFontSize(context, fontSize: 40),
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleRegular17(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF5C5858),
      fontSize: getResponsiveFontSize(context, fontSize: 17),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    );
  }
}

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;

  if (width < 800) {
    return width / 400;
  } else if (width < 1200) {
    return width / 500;
  } else {
    return width / 600;
  }
}
