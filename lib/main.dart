import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:crypto_currancy/helpers/dio_helper.dart';
import 'package:crypto_currancy/layouts/app_main_layout.dart';
import 'package:crypto_currancy/state_management/bloc/cubits/app_theme_cubit.dart';
import 'package:crypto_currancy/state_management/bloc/cubits/crupto_currencies_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CryptoCurrenciesCubit>(
            create: (context) => CryptoCurrenciesCubit()
              // ..getAllVsCurrencies(context)
              // ..getAllCurrencies(),
          ),
          BlocProvider<AppThemeCubit>(
            create: (BuildContext context) => AppThemeCubit(),
          ),
        ],
        child: BlocConsumer<AppThemeCubit, AppThemeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Crypto',
                theme: ThemeData(
                  applyElevationOverlayColor: true,
                  appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    elevation: 5,
                    titleTextStyle: Theme.of(context).textTheme.headline6,
                    backgroundColor: Colors.white.withOpacity(0.96),
                    foregroundColor: Colors.blue,
                    toolbarTextStyle: TextStyle(color: Colors.blue),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                      systemNavigationBarColor: Colors.white,
                      // systemNavigationBarDividerColor: Colors.grey,
                    ),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    elevation: 20,
                    backgroundColor: Colors.grey.shade100.withOpacity(0.99),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade700),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  snackBarTheme: SnackBarThemeData(
                    backgroundColor: Colors.white,
                    contentTextStyle: Theme.of(context).textTheme.subtitle1
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    bodyText2: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.normal),
                    subtitle2: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    subtitle1: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                    headline6: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                    headline5: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                    headline4: TextStyle(
                        fontSize: 22,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                    headline3: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: Colors.blue,
                  primaryColor: Colors.blue,
                  // shadowColor: Colors.cyanAccent.shade100,
                  primaryColorDark: Colors.green.shade200.withOpacity(0.55),
                  primaryColorLight: Colors.lightGreen.shade200.withOpacity(0.55),
                  iconTheme: IconThemeData(color: Colors.blue),
                  brightness: Brightness.light,
                  accentColorBrightness: Brightness.light,
                  primaryColorBrightness: Brightness.light,
                ),
                darkTheme: ThemeData(
                  applyElevationOverlayColor: true,
                  appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    elevation: 5,
                    backgroundColor: Colors.grey.shade700.withOpacity(0.96),
                    foregroundColor: Colors.white,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.grey.shade700.withOpacity(0.96),
                      statusBarIconBrightness: Brightness.light,
                      systemNavigationBarColor:
                          Colors.grey.shade700.withOpacity(0.96),
                      // systemNavigationBarDividerColor: Colors.grey,
                    ),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      elevation: 10,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.cyan,
                      backgroundColor: Colors.grey.shade600.withOpacity(0.5),
                      unselectedIconTheme: IconThemeData(color: Colors.white70),
                      unselectedLabelStyle: TextStyle(color: Colors.white70),
                      unselectedItemColor: Colors.white70),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.cyan.shade700.withOpacity(0.76)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  snackBarTheme: SnackBarThemeData(
                      backgroundColor: Colors.grey.shade700.withOpacity(0.96),
                      contentTextStyle: Theme.of(context).textTheme.subtitle1,
                    actionTextColor: Colors.white
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    bodyText2: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.normal),
                    subtitle2: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade300,
                        fontWeight: FontWeight.normal),
                    subtitle1: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                    headline6: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                    headline5: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                    headline4: TextStyle(
                        fontSize: 22,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                    headline3: TextStyle(
                        fontSize: 24,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                  scaffoldBackgroundColor: Colors.grey.shade700.withOpacity(0.96),
                  primarySwatch: Colors.cyan,
                  primaryColor: Colors.cyan,
                  // shadowColor: Colors.cyanAccent.shade100,
                  primaryColorDark:
                      Colors.deepPurpleAccent.shade200.withGreen(190).withOpacity(0.45),
                  primaryColorLight:
                      Colors.indigoAccent.shade100.withGreen(220).withOpacity(0.40),
                  brightness: Brightness.dark,
                  accentColorBrightness: Brightness.dark,
                  primaryColorBrightness: Brightness.dark,
                ),
                themeMode: (AppThemeCubit.instance(context).isDark)
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: AppMainLayout(title: 'Cryptoise'),
              );
            }),
      ),
    );
  }
}
