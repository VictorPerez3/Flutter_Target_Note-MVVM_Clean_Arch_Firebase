import 'package:get_it/get_it.dart';

import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/builders/field_validator_builder.dart';
import '../../../../core/base/dal/storage/storage_interface.dart';
import '../../../../core/base/injection/inject.dart';
import '../../../../core/base/models/text_react_field_model.dart';
import '../../../../core/resources/auth/dal/auth_repository.dart';
import '../../../../core/resources/auth/dal/datasource/firebase_authentication/fb_authentication_datasource_interface.dart';
import '../../../../core/resources/auth/domain/usecases/sign_up_usecase.dart';
import '../../../../core/resources/note/dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../../../../core/resources/note/domain/usecases/save_user_info_name_usecase.dart';
import '../presentation/sign_up_viewmodel.dart';
import '../presentation/tag/sign_up_tag.dart';

class SignUpViewModelBinding {
  static void inject() {
    Inject.injectViewModel<SignUpViewModel>(makeSignUpViewModel);
    if (!GetIt.instance.isRegistered<SignUpTag>()) {
      Inject.lazyPut<SignUpTag>(makeSignUpTag);
    }
  }

  static void dispose() {
    Inject.disposeViewModel<SignUpViewModel>();
    Inject.remove<SignUpTag>();
  }
}

SignUpViewModel makeSignUpViewModel() {
  final storage = Inject.find<IStorage>();
  final authDatasource = Inject.find<IFbAuthDataSource>();
  final firebaseDatabase = Inject.find<FbDatabaseProvider>();

  final authRepository = AuthRepository(
    storage: storage,
    authDataSource: authDatasource,
  );

  final signUpUsecase = SignUpUsecase(
      authRepository: authRepository, authDataSource: authDatasource);

  final saveUserInfoNameUsecase = SaveUserInfoNameUsecase(
      authRepository: authRepository, firebaseDatabase: firebaseDatabase);

  return SignUpViewModel(
      completeNameField: makeCompleteNameField(),
      emailField: makeEmailSignUpField(),
      passwordField: makePasswordSignUpField(),
      repeatPasswordField: makeRepeatPasswordField(),
      signUpUsecase: signUpUsecase,
      saveUserInfoNameUsecase: saveUserInfoNameUsecase);
}

SignUpTag makeSignUpTag() {
  return SignUpTag(Inject.find());
}

IField<String> makeCompleteNameField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().username().build(),
  );
}

IField<String> makeEmailSignUpField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().username().build(),
  );
}

IField<String> makePasswordSignUpField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().password().build(),
  );
}

IField<String> makeRepeatPasswordField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().password().build(),
  );
}
