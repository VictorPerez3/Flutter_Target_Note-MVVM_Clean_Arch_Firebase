import 'package:get_it/get_it.dart';

import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/builders/field_validator_builder.dart';
import '../../../../core/base/dal/storage/storage_interface.dart';
import '../../../../core/base/injection/inject.dart';
import '../../../../core/base/models/text_react_field_model.dart';
import '../../../../core/resources/auth/dal/auth_repository.dart';
import '../../../../core/resources/auth/dal/datasource/firebase_authentication/fb_authentication_datasource_interface.dart';
import '../../../../core/resources/auth/domain/usecases/sign_in_usecase.dart';
import '../presentation/sign_in_viewmodel.dart';
import '../presentation/tag/sign_in_tag.dart';

class SignInViewModelBinding {
  static void inject() {
    Inject.injectViewModel<SignInViewModel>(makeSignInViewModel);
    if (!GetIt.instance.isRegistered<SignInTag>()) {
      Inject.lazyPut<SignInTag>(makeSignInTag);
    }
  }

  static void dispose() {
    Inject.disposeViewModel<SignInViewModel>();
    Inject.remove<SignInTag>();
  }
}

SignInViewModel makeSignInViewModel() {
  final storage = Inject.find<IStorage>();
  final authDatasource = Inject.find<IFbAuthDataSource>();

  final authRepository = AuthRepository(
    storage: storage,
    authDataSource: authDatasource,
  );

  final authenticateUsecase = SignInUsecase(
      authRepository: authRepository, authDataSource: authDatasource);

  return SignInViewModel(
    emailField: makeEmailSignInField(),
    passwordField: makePasswordSignInField(),
    signInUsecase: authenticateUsecase,
  );
}

SignInTag makeSignInTag() {
  return SignInTag(Inject.find());
}

IField<String> makeEmailSignInField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().username().build(),
  );
}

IField<String> makePasswordSignInField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().password().build(),
  );
}
