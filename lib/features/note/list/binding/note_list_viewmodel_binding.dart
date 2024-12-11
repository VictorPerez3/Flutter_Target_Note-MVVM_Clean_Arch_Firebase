import 'package:get_it/get_it.dart';

import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/builders/field_validator_builder.dart';
import '../../../../core/base/dal/storage/storage_interface.dart';
import '../../../../core/base/injection/inject.dart';
import '../../../../core/base/models/text_react_field_model.dart';
import '../../../../core/resources/auth/dal/auth_repository.dart';
import '../../../../core/resources/auth/dal/datasource/firebase_authentication/fb_authentication_datasource_interface.dart';
import '../../../../core/resources/auth/domain/usecases/logout_usecase.dart';
import '../../../../core/resources/note/dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../../../../core/resources/note/domain/usecases/delete_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/edit_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/get_all_hidden_notes_usecase.dart';
import '../../../../core/resources/note/domain/usecases/get_unhidden_notes_by_notetype_usecase.dart';
import '../../../../core/resources/note/domain/usecases/get_user_info_name_usecase.dart';
import '../../../../core/resources/note/domain/usecases/save_note_usecase.dart';
import '../presentation/note_list_viewmodel.dart';
import '../presentation/tag/note_list_tag.dart';

class NoteListViewModelBinding {
  static void inject() {
    Inject.injectViewModel<NoteListViewModel>(makeNoteListViewModel);
    if (!GetIt.instance.isRegistered<NoteListTag>()) {
      Inject.lazyPut<NoteListTag>(makeNoteListTag);
    }
  }

  static void dispose() {
    Inject.disposeViewModel<NoteListViewModel>();
    Inject.remove<NoteListTag>();
  }
}

NoteListViewModel makeNoteListViewModel() {
  final storage = Inject.find<IStorage>();
  final firebaseDatabase = Inject.find<FbDatabaseProvider>();
  final authDatasource = Inject.find<IFbAuthDataSource>();

  final authRepository = AuthRepository(
    storage: storage,
    authDataSource: authDatasource,
  );

  final saveNoteUsecase = SaveNoteUseCase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final editNoteUsecase = EditNoteUseCase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final deleteNoteUsecase = DeleteNoteUseCase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final getUnhiddenNotesByNoteTypeUseCase = GetUnhiddenNotesByNoteTypeUseCase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final getAllHiddenNotesUseCase = GetAllHiddenNotesUseCase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final getUserInfoNameUsecase = GetUserInfoNameUsecase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final logoutUsecase = LogoutUsecase(authRepository: authRepository);

  return NoteListViewModel(
      titleField: makeTitleField(),
      noteTextField: makeNoteTextField(),
      userInfoNameTextField: makeUserInfoNameTextField(),
      deleteNoteUsecase: deleteNoteUsecase,
      getUnhiddenNotesByNoteTypeUseCase: getUnhiddenNotesByNoteTypeUseCase,
      getAllHiddenNotesUseCase: getAllHiddenNotesUseCase,
      getUserInfoNameUsecase: getUserInfoNameUsecase,
      logoutUsecase: logoutUsecase,
      saveNoteUsecase: saveNoteUsecase,
      editNoteUsecase: editNoteUsecase);
}

NoteListTag makeNoteListTag() {
  return NoteListTag(Inject.find());
}

IField<String> makeTitleField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
  );
}

IField<String> makeNoteTextField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
  );
}

IField<String> makeUserInfoNameTextField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
  );
}
