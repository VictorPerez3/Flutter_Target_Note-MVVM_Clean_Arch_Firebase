import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project_target/features/auth/presentation/auth_screen.dart';

import 'config.dart';
import 'core/base/firebase/cloud_messaging/fb_cloud_messaging_provider.dart';
import 'core/base/firebase/crashlytics/fb_crashlytics_provider.dart';
import 'core/base/injection/inject.dart';
import 'core/navigation/navigation.dart';
import 'core/navigation/routes.dart';
import 'initializer.dart';

void main() async {
  await runZonedGuarded(
    () async {
      await Initializer.init();
      Initializer.initialRoute = await Routes.initialRoute;

      final fbCloudMessaging = Inject.find<FbCloudMessagingProvider>();
      fbCloudMessaging.onMainApplication();

      runApp(const MyApp());
    },
    (error, stack) {
      final fbCrashlytics = Inject.find<FbCrashlyticsProvider>();
      fbCrashlytics.recordError(error, stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialApp(
      title: 'Flutter Project Target Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
    return MaterialApp.router(routerConfig: Navigation.router);
  }
}

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  const EnvironmentsBadge({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.production
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.staging ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}
