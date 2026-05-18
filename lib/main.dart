import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/app_router.dart';
import 'core/di/service_locator.dart';
import 'core/providers/auth_notifier.dart';

void main() {
  setupServiceLocator();
  runApp(const PleasantWaves());
}

class PleasantWaves extends StatelessWidget {
  const PleasantWaves({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthNotifier>.value(value: sl<AuthNotifier>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Pleasant Waves',
        theme: ThemeData(
          scaffoldBackgroundColor: C.bg,
          fontFamily: 'Inter',
          colorScheme: const ColorScheme.dark(
            primary: C.accent,
            surface: C.surface,
            onPrimary: C.textPri,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: C.card,
            hintStyle: const TextStyle(color: C.textSec, fontSize: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: C.card),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: C.accent, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: C.accent,
              foregroundColor: C.textPri,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
