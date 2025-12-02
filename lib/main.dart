import 'package:flutter/material.dart';
import 'package:remeal/navigation/auth_checker.dart';
import 'package:remeal/navigation/router_Generator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

const isLoggedIn = false;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF6750A4),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFEADDFF),
          onPrimaryContainer: Color(0xFF4F378B),
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD0BCFF),
          onPrimary: Color(0xFF381E72),
          primaryContainer: Color(0xFF4F378B),
          onPrimaryContainer: Color(0xFFEADDFF),
        ),
        brightness: Brightness.dark,
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      onGenerateRoute: AppRouter.generateRoute,
      home: const AuthChecker(),
    );
  }
}