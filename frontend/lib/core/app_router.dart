import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/autenticacao/domain/models/usuario_model.dart';
import '../features/autenticacao/presentation/screens/login_screen.dart';
import '../features/autenticacao/presentation/screens/register_screen.dart';
import '../features/catalogo/data/repositories/albums_repository.dart';
import '../features/catalogo/presentation/screens/album_detail_screen.dart';
import '../features/catalogo/presentation/screens/root_page.dart';
import 'theme/app_theme.dart';

/// Única fonte de verdade para autenticação na aplicação.
class Auth extends ChangeNotifier {
  Auth._();
  static final Auth instance = Auth._();

  bool _autenticado = false;
  Usuario? _usuarioAtual;

  bool get autenticado => _autenticado;
  Usuario? get usuarioAtual => _usuarioAtual;

  Future<bool> login(String email, String senha) async {
    await Future.delayed(const Duration(milliseconds: 900));
    if (senha != 'admin') return false;
    _autenticado = true;
    _usuarioAtual = Usuario(id: '1', nome: 'username', email: email);
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

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  refreshListenable: Auth.instance,
  redirect: (BuildContext context, GoRouterState state) {
    final isAuthRoute =
        state.matchedLocation == '/login' ||
        state.matchedLocation == '/register';
    if (!Auth.instance.autenticado && !isAuthRoute) return '/login';
    if (Auth.instance.autenticado && isAuthRoute) return '/home';
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const RootPage(),
    ),
    GoRoute(
      path: '/album/:id',
      name: 'album',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final album = findAlbumById(id);
        if (album == null) return const RootPage();
        return AlbumDetailScreen(album: album);
      },
    ),
  ],
  errorBuilder:
      (context, state) => Scaffold(
        backgroundColor: C.bg,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: C.textSec,
                size: 48,
              ),
              const SizedBox(height: 12),
              const Text(
                'Página não encontrada',
                style: TextStyle(color: C.textPri, fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.go('/home'),
                child: const Text(
                  'Voltar ao início',
                  style: TextStyle(color: C.accent),
                ),
              ),
            ],
          ),
        ),
      ),
);
