import 'package:flutter/material.dart';
import 'store.dart';
import 'login.dart';
import 'cut_corners_border.dart';
import 'colors.dart';

void main() => runApp(MyApp());

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material Design',
      home: Store(),
    );
  }
} */

//Store
class MyApp extends StatelessWidget {
  ThemeData _buildTheme(){
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      accentColor: kShrineBrown900,
      primaryColor: kShrinePink100,
      buttonColor: kShrinePink100,
      scaffoldBackgroundColor: kShrineBackgroundWhite,
      cardColor: kShrineBackgroundWhite,
      textSelectionColor: kShrinePink100,
      errorColor: kShrineErrorRed,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(
          color: kShrineBrown900
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: CutCornersBorder()
      )
    );
  }

  TextTheme _buildTextTheme(TextTheme text){
    return text.copyWith(
      headline: text.headline.copyWith(
        fontWeight: FontWeight.w500,
      ),
      title: text.title.copyWith(
          fontSize: 18.0
      ),
      caption: text.caption.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
    ).apply(
      fontFamily: 'Rubik',
      displayColor: kShrineBrown900,
      bodyColor: kShrineBrown900,
    );
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      title: 'Material Design',
      home: Store(),
    );
  }
}