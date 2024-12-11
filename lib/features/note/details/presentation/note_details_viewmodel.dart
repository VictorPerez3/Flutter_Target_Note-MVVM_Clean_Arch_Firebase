import 'package:flutter/cupertino.dart';
import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/abstractions/viewmodel_interface.dart';
import '../../../../core/resources/note/domain/constants/note_types_and_hide_constants.dart';
import '../../../../core/resources/note/domain/entities/note_entity.dart';
import '../../../../core/resources/note/domain/usecases/edit_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/get_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/save_note_usecase.dart';

class NoteDetailsViewModel extends IViewModel {
  final EditNoteUseCase editNoteUsecase;
  final GetNoteByNoteIdUseCase getNoteUsecase;
  final SaveNoteUseCase saveNoteUsecase;

  final IField<String> titleField;
  final IField<String> noteTextField;

  final ValueNotifier<String> noteTypeMode;
  final ValueNotifier<Color> backgroundColor;
  final ValueNotifier<TextAlign> noteTextAlign;
  final ValueNotifier<bool> isBottomSheetMinimized;
  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<TextAlign> selectedTextAlign;

  NoteDetailsViewModel({
    required this.titleField,
    required this.noteTextField,
    required this.editNoteUsecase,
    required this.getNoteUsecase,
    required this.saveNoteUsecase,
  })  : noteTypeMode =
            ValueNotifier<String>(NoteTypesAndHideConstants.generalNotes),
        backgroundColor = ValueNotifier<Color>(const Color(0xFFFEA289)),
        noteTextAlign = ValueNotifier<TextAlign>(TextAlign.left),
        isBottomSheetMinimized = ValueNotifier<bool>(false),
        selectedColor = ValueNotifier<Color>(const Color(0xFF1C1B1F)),
        selectedTextAlign = ValueNotifier<TextAlign>(TextAlign.left);

  void initializeNote(Note? note, String mode) {
    if (note == null) {
      noteTypeMode.value = mode;
      resetFields();
    } else {
      fillFieldsWithNoteData(note);
    }
  }

  String getNoteTypeButtonByNoteList({required Note? note}) {
    if (note?.hide == true) {
      return NoteTypesAndHideConstants.hiddenNotes;
    }
    return noteTypeMode.value;
  }

  void resetFields() {
    titleField.valueNotifier.value = '';
    noteTextField.valueNotifier.value = '';
  }

  void fillFieldsWithNoteData(Note note) {
    noteTypeMode.value = note.noteType;
    titleField.valueNotifier.value = note.title;
    noteTextField.valueNotifier.value = note.noteText;
    changeBackgroundColor(note.backgroundColor);
    changeTextAlign(note.alignmentText);
  }

  Future<void> handleSaveEditNote({
    required Note? note,
    required VoidCallback onSaveSuccess,
    required VoidCallback onEditSuccess,
    required Function onError,
  }) async {
    try {
      if (!isNoteValidForSaveOrEdit(note)) return;

      if (note == null) {
        await addNote();
        onSaveSuccess();
      } else {
        await editExistingNote(note);
        onEditSuccess();
      }
    } catch (err) {
      onError(err);
    }
  }

  bool isNoteValidForSaveOrEdit(Note? note) {
    return _noteTextFieldIsFilled() && _hasChanges(note);
  }

  bool _noteTextFieldIsFilled() {
    return noteTextField.valueNotifier.value!.isNotEmpty;
  }

  bool _hasChanges(Note? note) {
    return titleField.valueNotifier.value != note?.title ||
        noteTextField.valueNotifier.value != note?.noteText ||
        backgroundColor.value != note?.backgroundColor ||
        noteTextAlign.value != note?.alignmentText;
  }

  String _titleFieldNotFilled() {
    if (titleField.valueNotifier.value!.isNotEmpty) {
      return titleField.valueNotifier.value!;
    }
    return 'Saved Note';
  }

  Future<void> addNote() async {
    await saveNoteUsecase.saveNote(
      noteType: noteTypeMode.value,
      title: _titleFieldNotFilled(),
      noteText: noteTextField.valueNotifier.value!,
      hide: false,
      backgroundColor: backgroundColor.value,
      alignmentText: noteTextAlign.value,
    );
  }

  Future<void> editExistingNote(Note note) async {
    await editNoteUsecase.editNote(
      noteType: note.noteType,
      noteId: note.id,
      title: _titleFieldNotFilled(),
      noteText: noteTextField.valueNotifier.value!,
      hide: note.hide,
      backgroundColor: backgroundColor.value,
      alignmentText: noteTextAlign.value,
    );
  }

  void changeBackgroundColor(Color color) {
    backgroundColor.value = color;
    selectedColor.value = color;
  }

  void changeTextAlign(TextAlign align) {
    noteTextAlign.value = align;
    selectedTextAlign.value = align;
  }

  void toggleBottomSheet() {
    isBottomSheetMinimized.value = !isBottomSheetMinimized.value;
  }

  @override
  void dispose() {
    titleField.dispose();
    noteTextField.dispose();
    backgroundColor.dispose();
    noteTextAlign.dispose();
    isBottomSheetMinimized.dispose();
    selectedColor.dispose();
    selectedTextAlign.dispose();
  }
}
