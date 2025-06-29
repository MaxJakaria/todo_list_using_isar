import 'package:flutter/material.dart';
import 'package:todo_list_using_isar/core/app_pallete/app_pallete.dart';

ThemeData appTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: barBackground,

      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: title,
      ),
      iconTheme: IconThemeData(),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: button,
      shape: BorderDirectional(),
      hoverColor: button,
      splashColor: pressbutton,
    ),

    cardTheme: CardThemeData(
      shape: BeveledRectangleBorder(side: BorderSide.none),
      color: cardBackground,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: dialogBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      titleTextStyle: TextStyle(
        shadows: [Shadow(color: shadow, offset: Offset(0.5, 1), blurRadius: 4)],
        fontSize: 16,
        color: title,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: focused)),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focusedError),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          return (states.contains(WidgetState.pressed)) ? pressbutton : button;
        }),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),

        shadowColor: WidgetStateProperty.all<Color>(shadow),
        elevation: WidgetStateProperty.all<double>(5),
      ),
    ),
  );
}
