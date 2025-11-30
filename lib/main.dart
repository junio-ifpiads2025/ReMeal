import 'package:flutter/material.dart';
import 'package:remeal/navigation/auth_checker.dart';
import 'package:remeal/navigation/router_Generator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/utils/theme_notifier.dart';
import 'package:remeal/utils/preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDark = await Preferences.getDarkMode();
  runApp(
    ProviderScope(
      overrides: [
        themeNotifierProvider.overrideWith(
          (ref) => ThemeNotifier(isDark ? ThemeMode.dark : ThemeMode.light),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

const isLoggedIn = false;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      onGenerateRoute: AppRouter.generateRoute,
      home: AuthChecker(),
    );
  }
}
