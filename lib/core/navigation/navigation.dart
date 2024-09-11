import 'package:go_router/go_router.dart';

import '../../features/bindings.dart';
import '../../features/screens.dart';
import '../../initializer.dart';
import '../base/utils/entry_provider_util.dart';
import 'routes.dart';

class Navigation {
  static final router = GoRouter(
    initialLocation: Initializer.initialRoute,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.signIn,
        name: Routes.signIn,
        builder: (context, state) => EntryProvider(
          screenName: Routes.signIn,
          onBuild: (_) => const SignInScreen(),
          onInit: (_) => SignInViewModelBinding.inject(),
          onDispose: (_) => SignInViewModelBinding.dispose(),
        ),
      ),
      GoRoute(
        path: Routes.signUp,
        name: Routes.signUp,
        builder: (context, state) => EntryProvider(
          screenName: Routes.signUp,
          onBuild: (_) => const SignUpScreen(),
          onInit: (_) => SignUpViewModelBinding.inject(),
          onDispose: (_) => SignUpViewModelBinding.dispose(),
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
