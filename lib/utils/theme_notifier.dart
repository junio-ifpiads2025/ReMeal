import 'package:flutter/material.dart';

class ThemeNotifier extends ValueNotifier<ThemeMode> {
	ThemeNotifier(ThemeMode value) : super(value);

	void setDark(bool isDark) {
	    value = isDark ? ThemeMode.dark : ThemeMode.light;
		notifyListeners();
	}
}