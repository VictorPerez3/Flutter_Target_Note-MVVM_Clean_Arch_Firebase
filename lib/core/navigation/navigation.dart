import 'package:go_router/go_router.dart';

import '../../features/bindings.dart';
import '../../features/screens.dart';
import '../../initializer.dart';
import '../base/utils/entry_provider_util.dart';
import '../resources/note/domain/entities/note_entity.dart';
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
        path: Routes.noteList,
        name: Routes.noteList,
        builder: (context, state) => EntryProvider(
          screenName: Routes.noteList,
          onBuild: (_) => const NoteListScreen(),
          onInit: (_) => NoteListViewModelBinding.inject(),
          onDispose: (_) => NoteListViewModelBinding.dispose(),
        ),
      ),
      GoRoute(
        path: Routes.noteDetails,
        name: Routes.noteDetails,
        builder: (context, state) {

          final extraData = state.extra as Map<String, dynamic>;
          final Note? note = extraData['note'] as Note?;
          final String noteTypeMode = extraData['noteTypeMode'] as String;

          return EntryProvider(
            screenName: Routes.noteDetails,
            onBuild: (_) => NoteDetailsScreen(
              note: note,
              noteTypeMode: noteTypeMode,
            ),
            onInit: (_) => NoteDetailsViewModelBinding.inject(),
            onDispose: (_) => NoteDetailsViewModelBinding.dispose(),
          );
        },
      ),
    ],
  );
}
