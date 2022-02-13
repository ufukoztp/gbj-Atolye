import 'package:flutter/material.dart';

class AppTheme {
  static get theme {
    return ThemeData(
      splashColor: Colors.transparent ,
      primaryColor: AppTheme.bigStone[300],
      accentColor: AppTheme.bigStone[50],
      buttonColor: Colors.cyan[300],
      textSelectionColor:  AppTheme.bigStone[50],
      toggleableActiveColor: Colors.cyan[300],
      backgroundColor: solitude[50],
      cursorColor: AppTheme.azureRadiance[50],
      unselectedWidgetColor:AppTheme.lightGrey[50],
      inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.lightGrey[50])),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.lightGrey[50])),
      ),
      textTheme: TextTheme(

          headline6: TextStyle(
              color: AppTheme.bigStone[50],
              fontSize: 15.0,
              fontFamily: 'MontserratBold'),

          //Buton text fontu
          button: TextStyle(
              color: AppTheme.white[50],
              fontSize: 15.0,
              fontFamily: 'MontserratBold'),


          /* LinearGradient( colors: <Color>[
                        AppTheme.aqua[50],
                        AppTheme.azureRadiance[50],
                      ]),*/

          //Genel proje regular text rengi
          headline4: TextStyle(
              fontSize: 14.0,
              fontFamily: 'MontserratSemiBold',
              color: AppTheme.aqua[50]
          ),

          //Genel proje bold text rengi
          headline3: TextStyle(
              fontSize: 14.0,
              fontFamily: 'MontserratBold',
              color: AppTheme.aqua[50]),

          //Error Textler için yazılar için
          headline2: TextStyle(
              fontSize: 10.0,
              fontFamily: 'MontserratSemiBold',
              color: AppTheme.red[50]
          ),

          //Input hint yazıları için
          headline1: TextStyle(
              fontSize: 14.0,
              fontFamily: 'MontserratSemiBold',
              color: AppTheme.riverBed[50]),


      ),
    );
  }

  static const Map<int, Color> solitude = const <int, Color>{
    50: const Color(0xffF3F4F8)
  };
  static const Map<int, Color> red = const <int, Color>{
    50: const Color(0xffc03f38)
  };

  static const Map<int, Color> eclipse = const <int, Color>{
    50: const Color(0xff3C3C3C)
  };

  static const Map<int, Color> safetyOrange = const <int, Color>{
    50: const Color(0xffF78538)
  };

  static const Map<int, Color> safetyOrange2 = const <int, Color>{
    50: const Color(0xffCC9000)
  };

  static const Map<int, Color> darkTangerine = const <int, Color>{
    50: const Color(0xffFCB814)
  };

  static const Map<int, Color> lightGrey = const <int, Color>{
    50: const Color(0xffD0D0D0)
  };
  static const Map<int, Color> maGrey = const <int, Color>{
    50: const Color(0xffaaafb4)
  };
  static const Map<int, Color> middleGrey = const <int, Color>{
    50: const Color(0xffE6E6E6)
  };
  static const Map<int, Color> softGrey = const <int, Color>{
    50: const Color(0xffF2F2F2)
  };

  static const Map<int, Color> darkGreen = const <int, Color>{
    50: const Color(0xff27bf69)
  };

  static const Map<int, Color> darkRed = const <int, Color>{
    50: const Color(0xffcd0436)
  };


  static const Map<int, Color> aqua = const <int, Color>{
    50: const Color(0xffff6c4d)
  };
  static const Map<int, Color> collectionPageColor = const <int, Color>{
    50: const Color(0xff1b2d48)
  };
  static const Map<int, Color> collectionPageColorAqua = const <int, Color>{
    50: const Color(0xff00f0ff)
  };

  static const Map<int, Color> azureRadiance = const <int, Color>{
    50: const Color(0xffe50040)
  };

  static const Map<int, Color> riverBed = const <int, Color>{
    50: const Color(0xffe50040)
  };

  static const Map<int, Color> bigStone = const <int, Color>{
    50: const Color(0xffe50040)
  };

  static const Map<int, Color> tuna = const <int, Color>{
    50: const Color(0xff313133)
  };
  static const Map<int, Color> shark = const <int, Color>{
    50: const Color(0xff2A2A2C)
  };
  static const Map<int, Color> teak = const <int, Color>{
    50: const Color(0xffB39861)
  };
  static const Map<int, Color> white = const <int, Color>{
    50: const Color(0xffffffff)
  };
  static const Map<int, Color> grey = const <int, Color>{
    50: const Color(0xffaaafb4)
  };
  static const Map<int, Color> black = const <int, Color>{
    50: const Color(0xff000000),
    100: const Color(0x73000000),
    150 : const Color(0xff2f2f2f)
  };
}
