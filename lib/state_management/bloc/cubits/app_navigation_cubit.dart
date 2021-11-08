import 'package:bloc/bloc.dart';
import 'package:crypto_currancy/screens/market_price_screen.dart';
import 'package:crypto_currancy/screens/home_screen.dart';
import 'package:crypto_currancy/screens/platforms_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part '../states/app_navigation_state.dart';

class AppNavigationCubit extends Cubit<AppNavigationState> {
  AppNavigationCubit() : super(AppNavigationInitial());

  static AppNavigationCubit instance(BuildContext context) =>
      BlocProvider.of(context, listen: false);

  int currentIndex = 0;
  List<Widget> screens=[
    HomeScreen(),
    MarketPriceScreen(),
    PlatformsScreen()
  ];

  void modifyIndex(int index) {
    currentIndex = index;
    emit(AppNavigationChanged());
  }
}
