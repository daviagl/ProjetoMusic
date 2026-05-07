import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/autenticacao/domain/models/usuario_model.dart';
import '../features/autenticacao/presentation/screens/login_screen.dart';
import '../features/autenticacao/presentation/screens/register_screen.dart';
import '../features/catalogo/domain/models/album_model.dart';
import '../features/catalogo/presentation/screens/album_detail_screen.dart';
import '../features/catalogo/presentation/screens/root_page.dart';
import 'theme/app_theme.dart';

final List<Album> kAlbums = [
  const Album(
    id: 'the-dark-side-of-the-moon',
    abbr: 'DSOTM',
    title: 'The Dark Side of the Moon',
    artist: 'Pink Floyd',
    year: 1973,
    rating: 4.9,
    ratingCount: '10.5k',
    genre: 'Progressive Rock',
    about:
        'O oitavo álbum de estúdio da banda britânica Pink Floyd, lançado em 1973. Conhecido por sua produção inovadora e temas filosóficos, é um dos álbuns mais vendidos e aclamados de todos os tempos.',
    colorValue: 0xFF000000,
  ),
  const Album(
    id: 'abbey-road',
    abbr: 'AR',
    title: 'Abbey Road',
    artist: 'The Beatles',
    year: 1969,
    rating: 4.8,
    ratingCount: '9.8k',
    genre: 'Rock',
    about:
        'O décimo primeiro álbum de estúdio da banda britânica The Beatles, lançado em 1969. Conhecido por sua icônica capa e por faixas como "Come Together" e "Here Comes the Sun".',
    colorValue: 0xFF1A2A3A,
  ),
  const Album(
    id: 'rumours',
    abbr: 'RUM',
    title: 'Rumours',
    artist: 'Fleetwood Mac',
    year: 1977,
    rating: 4.8,
    ratingCount: '10.2k',
    genre: 'Rock',
    about:
        'O décimo primeiro álbum de estúdio da banda britânica-americana Fleetwood Mac, lançado em 1977. Conhecido por suas canções sobre relacionamentos turbulentos e por ser um dos álbuns mais vendidos de todos os tempos.',
    colorValue: 0xFF3A2A1A,
  ),
  const Album(
    id: 'hotel-california',
    abbr: 'HC',
    title: 'Hotel California',
    artist: 'Eagles',
    year: 1976,
    rating: 4.8,
    ratingCount: '9.6k',
    genre: 'Rock',
    about:
        'O quinto álbum de estúdio da banda americana Eagles, lançado em 1976. Conhecido por sua faixa-título e por ser um dos álbuns mais vendidos de todos os tempos.',
    colorValue: 0xFF2A3A1A,
  ),
];

Album? findAlbumById(String id) {
  try {
    return kAlbums.firstWhere((a) => a.id == id);
  } catch (_) {
    return null;
  }
}

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
