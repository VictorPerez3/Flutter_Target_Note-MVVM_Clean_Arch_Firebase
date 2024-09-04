import 'package:get_it/get_it.dart';

import '../../../core/base/abstractions/field_interface.dart';
import '../../../core/base/builders/field_validator_builder.dart';
import '../../../core/base/dal/storage/storage_interface.dart';
import '../../../core/base/injection/inject.dart';
import '../../../core/base/models/text_react_field_model.dart';
import '../../../core/resources/auth/dal/auth_repository.dart';
import '../../../core/resources/auth/dal/datasource/auth_datasource_interface.dart';
import '../../../core/resources/note/dal/datasource/note.datasource.interface.dart';
import '../../../core/resources/note/dal/note.repository.dart';
import '../presentation/note_viewmodel.dart';
import '../presentation/tag/note_tag.dart';
import '../usecases/note_usecase.dart';

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
  final noteDatasource = Inject.find<INoteDataSource>();
  final authDatasource = Inject.find<IAuthDataSource>();

  final noteRepository = NoteRepository(
    storage: storage,
    noteDataSource: noteDatasource,
  );

  final authRepository = AuthRepository(
    storage: storage,
    authDataSource: authDatasource,
  );

  final noteUsecase = NoteUsecase(
      noteRepository: noteRepository, authRepository: authRepository);

  return NoteViewModel(
      titleField: makeTitleField(),
      noteTextField: makeNoteTextField(),
      noteUsecase: noteUsecase);
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