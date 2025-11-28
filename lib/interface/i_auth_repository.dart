import 'package:remeal/models/user.dart';

// Estou utilizando esta interface para que o meu repository possa ser substituível por outro tipo de repository, 
// como uma repository de banco de dados ou firebase.
// Classe abstrata = Contrato
abstract class IAuthRepository {
  Future<User?> getCurrentUser(); // Recuperar usuário ao abrir o app
  Future<User> login(String email, String password);
  Future<void> register(String name, String email, String password);
  Future<void> logout();
}