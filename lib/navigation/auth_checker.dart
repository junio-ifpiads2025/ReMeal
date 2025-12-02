import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/controller/auth_provider.dart';
import 'package:remeal/navigation/bottom_navigation.dart';
import 'package:remeal/pages/auth/login.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const BottomNavigation(); // Usuário logado
        }
        return const Login(); // Usuário deslogado
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Erro: $error')),
      ),
    );
  }
}