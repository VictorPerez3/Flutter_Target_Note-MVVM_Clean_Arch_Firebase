import 'package:get_it/get_it.dart';

import '../../../core/base/abstractions/field.interface.dart';
import '../../../core/base/builders/field_validator.builder.dart';
import '../../../core/base/injection/inject.dart';
import '../../../core/base/models/text_react_field.model.dart';
import '../../../core/resources/auth/dal/auth.repository.dart';
import '../../../core/resources/auth/dal/datasource/auth.datasource.interface.dart';
import '../../../core/base/dal/storage/storage.interface.dart';
import '../presentation/auth.viewmodel.dart';
import '../presentation/tag/auth.tag.dart';
import '../usecases/authenticate.usecase.dart';

class AuthViewModelBinding {
  static void inject() {
    Inject.injectViewModel<AuthViewModel>(makeAuthViewModel);
    if (!GetIt.instance.isRegistered<AuthTag>()) {
      Inject.lazyPut<AuthTag>(makeAuthTag);
    }
  }

  static void dispose() {
    Inject.disposeViewModel<AuthViewModel>();
    Inject.remove<AuthTag>();
  }
}

AuthViewModel makeAuthViewModel() {
  final storage = Inject.find<IStorage>();
  final authDatasource = Inject.find<IAuthDataSource>();

  final authRepository = AuthRepository(
    storage: storage,
    authDataSource: authDatasource,
  );

  final authenticateUsecase = AuthenticateUsecase(
    authRepository: authRepository,
  );

  return AuthViewModel(
    completeNameField: makeCompleteNameField(),
    usernameField: makeUsernameField(),
    passwordField: makePasswordField(),
    repeatPasswordField: makeRepeatPasswordField(),
    authenticateUsecase: authenticateUsecase,
  );
}

AuthTag makeAuthTag() {
  return AuthTag(Inject.find());
}

IField<String> makeCompleteNameField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().username().build(),
  );
}

IField<String> makeUsernameField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().username().build(),
  );
}

IField<String> makePasswordField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().password().build(),
  );
}

IField<String> makeRepeatPasswordField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().password().build(),
  );
}
