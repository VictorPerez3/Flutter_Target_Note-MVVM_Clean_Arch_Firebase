import '../../i18n/translation.dart';
import '../injection/inject.dart';

mixin l18nMixin {
  StringsTranslations get l18n => Inject.find();
}