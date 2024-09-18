import 'package:get_it/get_it.dart';

import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/builders/field_validator_builder.dart';
import '../../../../core/base/dal/storage/storage_interface.dart';
import '../../../../core/base/injection/inject.dart';
import '../../../../core/base/models/text_react_field_model.dart';
import '../../../../core/resources/auth/dal/auth_repository.dart';
import '../../../../core/resources/auth/dal/datasource/firebase_authentication/fb_authentication_datasource_interface.dart';
import '../../../../core/resources/note/dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../../../../core/resources/note/domain/usecases/edit_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/get_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/save_note_usecase.dart';
import '../presentation/note_details_viewmodel.dart';
import '../presentation/tag/note_details_tag.dart';

class NoteDetailsViewModelBinding {
  static void inject() {
    Inject.injectViewModel<NoteDetailsViewModel>(makeNoteDetailsViewModel);
    if (!GetIt.instance.isRegistered<NoteDetailsTag>()) {
      Inject.lazyPut<NoteDetailsTag>(makeNoteDetailsTag);
    }
  }

  static void dispose() {
    Inject.disposeViewModel<NoteDetailsViewModel>();
    Inject.remove<NoteDetailsTag>();
  }
}

NoteDetailsViewModel makeNoteDetailsViewModel() {
  final storage = Inject.find<IStorage>();
  final firebaseDatabase = Inject.find<FbDatabaseProvider>();
  final authDatasource = Inject.find<IFbAuthDataSource>();

  final authRepository = AuthRepository(
    storage: storage,
    authDataSource: authDatasource,
  );

  final editNoteUsecase = EditNoteUsecase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final getNoteUsecase = GetNoteUsecase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  final saveNoteUsecase = SaveNoteUsecase(
      firebaseDatabase: firebaseDatabase, authRepository: authRepository);

  return NoteDetailsViewModel(
      titleField: makeDetailsTitleField(),
      noteTextField: makeDetailsNoteTextField(),
      editNoteUsecase: editNoteUsecase,
      getNoteUsecase: getNoteUsecase,
      saveNoteUsecase: saveNoteUsecase);
}

NoteDetailsTag makeNoteDetailsTag() {
  return NoteDetailsTag(Inject.find());
}

IField<String> makeDetailsTitleField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
  );
}

IField<String> makeDetailsNoteTextField() {
  return TextReactFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
  );
}
