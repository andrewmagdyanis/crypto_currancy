import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part '../states/app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());

  static AppThemeCubit instance(BuildContext context) =>
      BlocProvider.of(context, listen: false);

  bool isDark = false;

  void changeAppTheme() {
    isDark = !isDark;
    if (isDark) {
      emit(AppThemeDark());
    } else {
      emit(AppThemeLight());
    }
  }
}
