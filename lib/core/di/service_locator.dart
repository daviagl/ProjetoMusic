import 'package:get_it/get_it.dart';
import '../providers/auth_notifier.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<AuthNotifier>(() => AuthNotifier());
}
