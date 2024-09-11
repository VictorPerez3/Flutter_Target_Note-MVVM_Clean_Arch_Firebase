import 'package:get_it/get_it.dart';

import '../../../core/base/abstractions/field_interface.dart';
import '../../../core/base/builders/field_validator_builder.dart';
import '../../../core/base/dal/storage/storage_interface.dart';
import '../../../core/base/injection/inject.dart';
import '../../../core/base/models/text_react_field_model.dart';
import '../../../core/resources/auth/dal/auth_repository.dart';
import '../../../core/resources/auth/dal/datasource/firebase_authentication/fb_authentication_datasource_interface.dart';
import '../../../core/resources/auth/domain/usecases/logout_usecase.dart';
import '../../../core/resources/note/dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../../../core/resources/note/domain/usecases/delete_note_usecase.dart';
import '../../../core/resources/note/domain/usecases/edit_note_usecase.dart';
import '../../../core/resources/note/domain/usecases/get_all_notes_usecase.dart';
import '../../../core/resources/note/domain/usecases/get_note_usecase.dart';
import '../../../core/resources/note/domain/usecases/save_note_usecase.dart';
import '../presentation/note_viewmodel.dart';
import '../presentation/tag/note_tag.dart';

class NoteViewModelBinding {
  static void inject() {
    Inject.injectViewModel<NoteViewModel>(makeNoteViewModel);
    if (!GetIt.instance.isRegistered<NoteTag>()) {
      Inject.lazyPut<NoteTag>(makeNoteTag);
    }
  }

  static void dispose() {
    Inject.disposeViewModel<NoteViewModel>();
    Inject.remove<NoteTag>();
  }
}

NoteViewModel makeNoteViewModel() {
  final storage = Inject.find<IStorage>();
  final firebaseDatabase = Inject.find<FbDatabaseProvider>();
  final authDatasource = Inject.find<IFbAuthDataSource>();

  final authRepository = AuthRepository(
    storage: storage,
    authDataSource: authDatasource,
  );

  final deleteNoteUsecase = DeleteNoteUsecase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final editNoteUsecase = EditNoteUsecase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final getAllNotesUsecase = GetAllNotesUsecase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final getNoteUsecase = GetNoteUsecase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final saveNoteUsecase = SaveNoteUsecase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final logoutUsecase = LogoutUsecase(authRepository: authRepository);

  return NoteViewModel(
      titleField: makeTitleField(),
      noteTextField: makeNoteTextField(),
      deleteNoteUsecase: deleteNoteUsecase,
      editNoteUsecase: editNoteUsecase,
      getAllNotesUsecase: getAllNotesUsecase,
      getNoteUsecase: getNoteUsecase,
      saveNoteUsecase: saveNoteUsecase,
      logoutUsecase: logoutUsecase);
}

NoteTag makeNoteTag() {
  return NoteTag(Inject.find());
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
