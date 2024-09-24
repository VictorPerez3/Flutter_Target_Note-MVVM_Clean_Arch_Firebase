import 'package:flutter/cupertino.dart';
import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/abstractions/viewmodel_interface.dart';
import '../../../../core/resources/note/domain/entities/note_entity.dart';
import '../../../../core/resources/note/domain/usecases/edit_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/get_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/save_note_usecase.dart';

class NoteDetailsViewModel extends IViewModel {
  final EditNoteUsecase editNoteUsecase;
  final GetNoteUsecase getNoteUsecase;
  final SaveNoteUsecase saveNoteUsecase;

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
  })  : noteTypeMode = ValueNotifier<String>("notes"),
        backgroundColor = ValueNotifier<Color>(const Color(0xFF1C1B1F)),
        noteTextAlign = ValueNotifier<TextAlign>(TextAlign.left),
        isBottomSheetMinimized = ValueNotifier<bool>(false),
        selectedColor = ValueNotifier<Color>(const Color(0xFF1C1B1F)),
        selectedTextAlign = ValueNotifier<TextAlign>(TextAlign.left);

  void initializeNote(Note? note, String mode) {
    if (note == null) {
      resetFields();
    } else {
      fillFieldsWithNoteData(note, mode);
    }
  }

  void resetFields() {
    titleField.valueNotifier.value = '';
    noteTextField.valueNotifier.value = '';
    noteTypeMode.value = "notes";
  }

  void fillFieldsWithNoteData(Note note, String mode) {
    titleField.valueNotifier.value = note.title;
    noteTextField.valueNotifier.value = note.noteText;
    noteTypeMode.value = mode;
    changeBackgroundColor(note.backgroundColor);
    changeTextAlign(note.alignmentText);
  }

  String getNoteTypeLabel() {
    switch (noteTypeMode.value) {
      case "notes":
        return "#Note";
      case "personal_accounts":
        return "#PersonalAccounts";
      case "bank_notes":
        return "#BankNotes";
      default:
        return "#Unknown";
    }
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
    return _isFilled() && _hasChanges(note);
  }

  bool _isFilled() {
    return titleField.valueNotifier.value!.isNotEmpty &&
        noteTextField.valueNotifier.value!.isNotEmpty;
  }

  bool _hasChanges(Note? note) {
    return titleField.valueNotifier.value != note?.title ||
        noteTextField.valueNotifier.value != note?.noteText ||
        backgroundColor.value != note?.backgroundColor ||
        noteTextAlign.value != note?.alignmentText;
  }

  Future<void> addNote() async {
    await saveNoteUsecase.saveNote(
      noteType: noteTypeMode.value,
      title: titleField.valueNotifier.value!,
      noteText: noteTextField.valueNotifier.value!,
      hashtags: _mockHashtags(),
      backgroundColor: backgroundColor.value,
      alignmentText: noteTextAlign.value,
    );
  }

  Future<void> editExistingNote(Note note) async {
    await editNoteUsecase.editNote(
      noteType: noteTypeMode.value,
      noteId: note.id,
      title: titleField.valueNotifier.value!,
      noteText: noteTextField.valueNotifier.value!,
      hashtags: _mockHashtags(),
      backgroundColor: backgroundColor.value,
      alignmentText: noteTextAlign.value,
    );
  }

  List<String> _mockHashtags() => ['work', 'travel']; // Hashtags Mockadas

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
