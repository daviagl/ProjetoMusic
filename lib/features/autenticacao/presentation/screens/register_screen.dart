import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/auth_notifier.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  final _confirmaSenhaCtrl = TextEditingController();
  final _nomeFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _senhaFocus = FocusNode();
  final _confirmaSenhaFocus = FocusNode();
  bool _senhaVisivel = false;
  bool _confirmaSenhaVisivel = false;
  bool _carregando = false;

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    _confirmaSenhaCtrl.dispose();
    _nomeFocus.dispose();
    _emailFocus.dispose();
    _senhaFocus.dispose();
    _confirmaSenhaFocus.dispose();
    super.dispose();
  }

  Future<void> _registrar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _carregando = true);
    await context.read<AuthNotifier>().register(
      _nomeCtrl.text.trim(),
      _emailCtrl.text.trim(),
    );
    if (!mounted) return;
    setState(() => _carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      backgroundColor: C.bg,
      appBar: AppBar(
        backgroundColor: C.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: C.textSec,
            size: 18,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Criar conta',
          style: TextStyle(
            color: C.textPri,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? size.width * 0.2 : 24,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Junte-se ao Pleasant Waves',
                  style: TextStyle(
                    color: C.textPri,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Crie sua conta e descubra oque estão achando das músicas!',
                  style: TextStyle(color: C.textSec, fontSize: 13),
                ),
                const SizedBox(height: 28),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const _FieldLabel(label: 'NOME DE USUÁRIO'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _nomeCtrl,
                        focusNode: _nomeFocus,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted:
                            (_) => FocusScope.of(
                              context,
                            ).requestFocus(_emailFocus),
                        style: const TextStyle(color: C.textPri, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: C.textSec,
                            size: 18,
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty)
                            return 'Informe um nome de usuário';
                          if (v.trim().length < 3)
                            return 'Mínimo de 3 caracteres';
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
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
                        style: const TextStyle(color: C.textPri, fontSize: 14),
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
                          if (!v.contains('@') || !v.contains('.'))
                            return 'E-mail inválido';
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
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted:
                            (_) => FocusScope.of(
                              context,
                            ).requestFocus(_confirmaSenhaFocus),
                        style: const TextStyle(color: C.textPri, fontSize: 14),
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
                            return 'Informe uma senha';
                          if (v.length < 6)
                            return 'A senha deve ter ao menos 6 caracteres';
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      const _FieldLabel(label: 'CONFIRMAR SENHA'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _confirmaSenhaCtrl,
                        focusNode: _confirmaSenhaFocus,
                        obscureText: !_confirmaSenhaVisivel,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _registrar(),
                        style: const TextStyle(color: C.textPri, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: C.textSec,
                            size: 18,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _confirmaSenhaVisivel
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: C.textSec,
                              size: 18,
                            ),
                            onPressed:
                                () => setState(
                                  () =>
                                      _confirmaSenhaVisivel =
                                          !_confirmaSenhaVisivel,
                                ),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return 'Confirme sua senha';
                          if (v != _senhaCtrl.text)
                            return 'As senhas não coincidem';
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      _carregando
                          ? const SizedBox(
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(color: C.accent),
                            ),
                          )
                          : ElevatedButton(
                            onPressed: _registrar,
                            child: const Text('CRIAR CONTA'),
                          ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Já tem uma conta? ',
                            style: TextStyle(color: C.textSec, fontSize: 13),
                          ),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                color: C.accent,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
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
