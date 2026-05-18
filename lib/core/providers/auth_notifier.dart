import 'package:flutter/foundation.dart';
import '../../features/autenticacao/domain/models/usuario_model.dart';

class AuthNotifier extends ChangeNotifier {
  bool _autenticado = false;
  Usuario? _usuarioAtual;

  bool get autenticado => _autenticado;
  Usuario? get usuarioAtual => _usuarioAtual;

  Future<bool> login(String email, String senha) async {
    await Future.delayed(const Duration(milliseconds: 900));
    if (senha != 'admin') return false;
    _autenticado = true;
    _usuarioAtual = Usuario(id: '1', nome: 'UsuarioTeste2000', email: email);
    notifyListeners();
    return true;
  }

  Future<void> register(String nome, String email) async {
    await Future.delayed(const Duration(milliseconds: 900));
    _autenticado = true;
    _usuarioAtual = Usuario(id: '1', nome: nome, email: email);
    notifyListeners();
  }

  void logout() {
    _autenticado = false;
    _usuarioAtual = null;
    notifyListeners();
  }
}
