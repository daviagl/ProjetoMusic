import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  final _emailFocus = FocusNode();
  final _senhaFocus = FocusNode();
  bool _senhaVisivel = false;
  bool _carregando = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    _emailFocus.dispose();
    _senhaFocus.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _carregando = true);

    final sucesso = await Auth.instance.login(
      _emailCtrl.text.trim(),
      _senhaCtrl.text,
    );

    if (!mounted) return;
    setState(() => _carregando = false);

    if (!sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('E-mail ou senha inválidos.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      backgroundColor: C.bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? size.width * 0.2 : 24,
                vertical: 0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      const Center(child: _Logo()),
                      const SizedBox(height: 40),
                      const Text(
                        'Entrar',
                        style: TextStyle(
                          color: C.textPri,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Bem-vindo de volta',
                        style: TextStyle(color: C.textSec, fontSize: 14),
                      ),
                      const SizedBox(height: 32),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const _FieldLabel(label: 'E-MAIL'),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _emailCtrl,
                              focusNode: _emailFocus,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted:
                                  (_) => FocusScope.of(
                                    context,
                                  ).requestFocus(_senhaFocus),
                              style: const TextStyle(
                                color: C.textPri,
                                fontSize: 14,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'seu@email.com',
                                prefixIcon: Icon(
                                  Icons.mail_outline_rounded,
                                  color: C.textSec,
                                  size: 18,
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty)
                                  return 'Informe seu e-mail';
                                if (!v.contains('@')) return 'E-mail inválido';
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            const _FieldLabel(label: 'SENHA'),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _senhaCtrl,
                              focusNode: _senhaFocus,
                              obscureText: !_senhaVisivel,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _entrar(),
                              style: const TextStyle(
                                color: C.textPri,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText: '••••••••',
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: C.textSec,
                                  size: 18,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _senhaVisivel
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: C.textSec,
                                    size: 18,
                                  ),
                                  onPressed:
                                      () => setState(
                                        () => _senhaVisivel = !_senhaVisivel,
                                      ),
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty)
                                  return 'Informe sua senha';
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                    color: C.accent,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            _carregando
                                ? const SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: C.accent,
                                    ),
                                  ),
                                )
                                : ElevatedButton(
                                  onPressed: _entrar,
                                  child: const Text('ENTRAR'),
                                ),
                            const SizedBox(height: 20),
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(color: C.card, thickness: 1),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    'ou',
                                    style: TextStyle(
                                      color: C.textMut,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(color: C.card, thickness: 1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            OutlinedButton(
                              onPressed: () => context.push('/register'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: C.textPri,
                                minimumSize: const Size(double.infinity, 50),
                                side: const BorderSide(color: C.card, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'CRIAR CONTA',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: C.accent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.music_note_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
      const SizedBox(width: 10),
      const Text(
        'Pleasant Waves',
        style: TextStyle(
          color: C.textPri,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
      ),
    ],
  );
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      label,
      style: const TextStyle(
        color: C.textSec,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
    ),
  );
}
