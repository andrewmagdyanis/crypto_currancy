import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:crypto_currancy/state_management/bloc/cubits/app_navigation_cubit.dart';
import 'package:crypto_currancy/state_management/bloc/cubits/app_theme_cubit.dart';
import 'package:crypto_currancy/state_management/bloc/cubits/crupto_currencies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppMainLayout extends StatefulWidget {
  AppMainLayout({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AppMainLayoutState createState() => _AppMainLayoutState();
}

class _AppMainLayoutState extends State<AppMainLayout> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    CryptoCurrenciesCubit.instance(context)
      ..getAllVsCurrencies(context)
      ..getAllCurrencies()
      ..getAllMarketCurrencies();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        print('connectivity changed to on');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Internet connection established'),
            backgroundColor: Colors.green,
          ),
        );
        CryptoCurrenciesCubit.instance(context).getAllVsCurrencies(context);
        CryptoCurrenciesCubit.instance(context).getAllCurrencies();
        CryptoCurrenciesCubit.instance(context).getAllMarketCurrencies();
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppNavigationCubit>(
      create: (context) => AppNavigationCubit(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: [
            IconButton(
              onPressed: () {
                AppThemeCubit.instance(context).changeAppTheme();
              },
              icon: BlocConsumer<AppThemeCubit, AppThemeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is AppThemeDark) {
                      return Icon(Icons.brightness_7_outlined);
                    } else {
                      return Icon(Icons.brightness_3);
                    }
                  }),
            ),
          ],
        ),
        bottomNavigationBar:
            BlocConsumer<AppNavigationCubit, AppNavigationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return BottomNavigationBar(
                    currentIndex:
                        AppNavigationCubit.instance(context).currentIndex,
                    onTap: (index) {
                      AppNavigationCubit.instance(context).modifyIndex(index);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.monetization_on_outlined),
                        label: 'Market',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: 'Settings',
                      )
                    ],
                  );
                }),
        body: BlocConsumer<AppNavigationCubit, AppNavigationState>(
            listener: (context, state) {},
            builder: (context, state) {
              AppNavigationCubit appNavCubit =
                  AppNavigationCubit.instance(context);
              return appNavCubit.screens[appNavCubit.currentIndex];
            }),
      ),
    );
  }
}
