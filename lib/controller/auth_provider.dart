import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remeal/interface/i_auth_repository.dart';
import 'package:remeal/models/user.dart';
import 'package:remeal/repository/local_auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return LocalAuthRepository();
});

class AuthController extends AsyncNotifier<User?> {
  
  @override
  Future<User?> build() async {
    final repo = ref.read(authRepositoryProvider);
    return repo.getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    //state = const AsyncValue.loading();
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.login(email, password);
      state = AsyncValue.data(user);
    
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.register(name, email, password);
      
      // Após registrar, já fazemos o login automaticamente
      await login(email, password);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.logout();
    state = const AsyncValue.data(null);
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, User?>(() {
  return AuthController();
});