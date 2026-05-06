import '../../domain/models/usuario_model.dart';

class AuthRepository {
  AuthRepository._();
  static final AuthRepository instance = AuthRepository._();

  bool _autenticado = false;
  Usuario? _usuarioAtual;

  bool get autenticado => _autenticado;
  Usuario? get usuarioAtual => _usuarioAtual;

  Future<bool> login(String email, String senha) async {
    await Future.delayed(const Duration(milliseconds: 900));
    if (senha != 'admin') return false;
    _autenticado = true;
    _usuarioAtual = Usuario(id: '1', nome: 'username', email: email);
    return true;
  }

  Future<void> register(String nome, String email) async {
    await Future.delayed(const Duration(milliseconds: 900));
    _autenticado = true;
    _usuarioAtual = Usuario(id: '1', nome: nome, email: email);
  }

  void logout() {
    _autenticado = false;
    _usuarioAtual = null;
  }
}
