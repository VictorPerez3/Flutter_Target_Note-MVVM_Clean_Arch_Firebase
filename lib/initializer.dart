import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_target/core/resources/auth/dal/datasource/auth.datasource.interface.dart';
import 'package:flutter_project_target/core/base/firebase/realtime_database/models/fb.database.dart';
import 'package:get_storage/get_storage.dart';
import 'package:devicelocale/devicelocale.dart';

import 'config.dart';
import 'core/base/constants/storage.constants.dart';
import 'core/base/dal/storage/getx_storage.dart';
import 'core/base/dal/storage/storage.interface.dart';
import 'core/base/firebase/analytics/analytics_mock.dart';
import 'core/base/firebase/analytics/analytics_provider.dart';
import 'core/base/firebase/analytics/models/fb.analytics.dart';
import 'core/base/firebase/cloud_messaging/cloud_messaging_provider.dart';
import 'core/base/firebase/cloud_messaging/models/fb.cloud_messaging.dart';
import 'core/base/firebase/crashlytics/crashlytics_mock.dart';
import 'core/base/firebase/crashlytics/crashlytics_provider.dart';
import 'core/base/firebase/crashlytics/models/fb.crashlytics.dart';
import 'core/base/firebase/realtime_database/database_provider.dart';
import 'core/base/injection/inject.dart';
import 'core/i18n/pt_br.dart';
import 'core/i18n/en_us.dart';
import 'core/i18n/translation.dart';
import 'core/resources/auth/dal/datasource/auth.datasource.dart';
import 'core/resources/note/dal/datasource/note.datasource.dart';
import 'core/resources/note/dal/datasource/note.datasource.interface.dart';
import 'features/auth/binding/auth_viewmodel.binding.dart';
import 'features/note/binding/note_viewmodel.binding.dart';
import 'features/shared/loading/loading.viewmodel.dart';
import 'firebase_options.dart';

class Initializer {
  static late final String initialRoute;

  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _initScreenPreference();
      _initGlobalLoading();
      await _initStorage();
      await _initI18n();
      await _initFirebase();
      await _initCrashlytics();
      await _initPushNotifications();
      _initAnalytics();
      _initFirebaseDatabase();
      // await _initConnectApi();
      _initDatasourceDependencies();
      _initViewModelDependencies();
    } catch (err) {
      rethrow;
    }
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void _initGlobalLoading() {
    final loading = LoadingViewModel();
    Inject.put<LoadingViewModel>(loading);
  }

  static void _initDatasourceDependencies() {
    final firebaseDatabase = FbDatabaseImpl();
    final authDatasource = AuthDataSource();
    final noteDatasource = NoteDataSource(firebaseDatabase);
    Inject.put<IAuthDataSource>(authDatasource);
    Inject.put<INoteDataSource>(noteDatasource);
  }

  static void _initViewModelDependencies() {
    AuthViewModelBinding.inject();
    NoteViewModelBinding.inject();
  }

  static Future<void> _initStorage() async {
    await GetStorage.init();
    final storage = GetXStorage();
    Inject.put<IStorage>(storage);
  }

  static Future<void> _initI18n() async {
    StringsTranslations getCurrentI18n(String locale) {
      switch (locale) {
        case PtBrStringsTranslations.getLocale:
          return PtBrStringsTranslations();
        case EnUsStringsTranslations.getLocale:
          return EnUsStringsTranslations();
        default:
          return PtBrStringsTranslations();
      }
    }

    final storage = Inject.find<IStorage>();
    final locale = await storage.read(StorageConstants.locale);

    late StringsTranslations i18n;
    if (locale != null) {
      i18n = getCurrentI18n(locale);
    } else {
      final currentLocale = await Devicelocale.currentLocale;
      if (currentLocale != null) {
        i18n = getCurrentI18n(currentLocale);
      } else {
        i18n = EnUsStringsTranslations();
      }
    }

    Inject.put<StringsTranslations>(i18n);
  }

  static Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> _initCrashlytics() async {
    final crashlyticsProvider = kDebugMode
        ? CrashlyticsMock(includeStackTrace: false)
        : FbCrashlyticsImpl();

    Inject.put<FbCrashlyticsProvider>(crashlyticsProvider);

    await crashlyticsProvider.setCrashlyticsCollectionEnabled(!kDebugMode);
    await crashlyticsProvider.setCustomKey(
      'environment',
      ConfigEnvironments.getEnvironments.toString(),
    );
    FlutterError.onError = crashlyticsProvider.recordFlutterFatalError;
  }

  static void _initAnalytics() {
    final provider = kDebugMode ? AnalyticsMock() : FbAnalyticsImpl();
    Inject.put<FbAnalyticsProvider>(provider);
  }

  static void _initFirebaseDatabase() {
    final provider = FbDatabaseImpl();
    Inject.put<FbDatabaseProvider>(provider);
  }

  static Future<void> _initPushNotifications() async {
    final provider = FbCloudMessagingImpl();
    Inject.put<FbCloudMessagingProvider>(provider);
  }
}
