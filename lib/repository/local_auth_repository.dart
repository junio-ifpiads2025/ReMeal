import 'dart:convert';
import 'package:remeal/interface/i_auth_repository.dart';
import 'package:remeal/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocalAuthRepository implements IAuthRepository {
  // Gerador de UUID
  static const _uuid = Uuid();
  // Chave para a SESSÃO ATUAL (Login persistente)
  static const _sessionKey = 'current_session';
  // Chave para o "BANCO DE DADOS" (Todos os usuários cadastrados)
  static const _dbKey = 'users_db';

  // --- 1. RECUPERAR SESSÃO ---
  @override
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_sessionKey);
    if (jsonString != null) {
      return User.fromJson(jsonString);
    }
    return null;
  }

  // --- 2. REGISTRAR NOVO USUÁRIO ---
  @override
  Future<void> register(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    // 1. Ler usuários existentes
    final List<String> usersJson = prefs.getStringList(_dbKey) ?? [];
    
    // 2. Verificar se email já existe
    for (var u in usersJson) {
      final userMap = json.decode(u);
      if (userMap['email'] == email) {
        throw Exception('Email já cadastrado!');
      }
    }

    // 3. Criar novo usuário com UUID único
    final newUser = User(
      id: _uuid.v4(), // UUID v4 (aleatório e único)
      name: name,
      email: email,
      password: password, // Salvando senha (apenas para teste local!)
    );

    // 4. Salvar na lista
    usersJson.add(newUser.toJson());
    await prefs.setStringList(_dbKey, usersJson);
  }

  // --- 3. LOGIN ---
  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Fake delay
    final prefs = await SharedPreferences.getInstance();
    
    // 1. Ler usuários do "Banco"
    final List<String> usersJson = prefs.getStringList(_dbKey) ?? [];

    // 2. Procurar usuário compatível
    User? foundUser;
    for (var u in usersJson) {
      final userObj = User.fromJson(u);
      if (userObj.email == email && userObj.password == password) {
        foundUser = userObj;
        break;
      }
    }

    if (foundUser == null) {
      throw Exception('Email ou senha inválidos');
    }

    // 3. Gerar um "JWT Fake" e salvar SESSÃO
    // Criamos um novo objeto user COM o token, mas SEM a senha (segurança da sessão)
    final sessionUser = User(
      id: foundUser.id,
      name: foundUser.name,
      email: foundUser.email,
      password: null, // Não salvar senha na sessão
    );

    await prefs.setString(_sessionKey, sessionUser.toJson());
    return sessionUser;
  }

  // --- 4. LOGOUT ---
  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey); // Remove apenas a sessão, não os usuários
  }
}