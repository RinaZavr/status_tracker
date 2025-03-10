import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(brightness: Brightness.dark));

  void toggleTheme() {
    emit(
      ThemeState(
        brightness: state.isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
