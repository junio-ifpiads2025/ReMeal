import 'package:remeal/models/user.dart';


// Classe abstrata = Contrato
abstract class IAuthRepository {
  Future<User?> getCurrentUser(); // Recuperar usuário ao abrir o app
  Future<User> login(String email, String password);
  Future<void> register(String name, String email, String password);
  Future<void> logout();
}