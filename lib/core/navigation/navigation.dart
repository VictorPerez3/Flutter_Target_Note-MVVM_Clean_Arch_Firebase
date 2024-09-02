import 'package:go_router/go_router.dart';

import '../../features/bindings.dart';
import '../../features/screens.dart';
import '../../initializer.dart';
import '../base/utils/entry_provider.util.dart';
import 'routes.dart';

class Navigation {
  static final router = GoRouter(
    initialLocation: Initializer.initialRoute,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.auth,
        name: Routes.auth,
        builder: (context, state) => EntryProvider(
          screenName: Routes.auth,
          onBuild: (_) => const AuthScreen(),
          onInit: (_) => AuthViewModelBinding.inject(),
          onDispose: (_) => AuthViewModelBinding.dispose(),
        ),
      ),
      GoRoute(
        path: Routes.note,
        name: Routes.note,
        builder: (context, state) => EntryProvider(
          screenName: Routes.note,
          onBuild: (_) => const NoteScreen(),
          onInit: (_) => NoteViewModelBinding.inject(),
          onDispose: (_) => NoteViewModelBinding.dispose(),
        ),
      ),
    ],
  );
}
