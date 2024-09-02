import 'package:flutter_project_target/core/i18n/contexts/auth_error.strings.dart';

import 'contexts/auth_screen.strings.dart';
import 'contexts/general.strings.dart';
import 'contexts/note_error.strings.dart';
import 'contexts/note_screen.strings.dart';
import 'contexts/validators.strings.dart';
import 'translation.dart';

class PtBrStringsTranslations implements StringsTranslations {
  static const String getLocale = 'pt-BR';

  final loginPage = AuthScreenStrings(
    titleLabel: 'Project Target Note',
    userNameLabel: 'E-mail',
    passwordLabel: 'Senha',
    signInButtonLabel: 'Entrar',
    signUpButtonLabel: 'Criar Usuário',
    addUserToast: 'Novo Usuário Criado',
  );

  final notePage = NoteScreenStrings(
      removeItemToast: 'Nota removida',
      addItemToast: 'Nota adicionada',
      editItemToast: 'Nota editada',
      newRegisterButton: 'Novo Registro',
      textLabelModal: 'Detalhes da nota',
      titleLabelModal: 'Título',
      noteTextLabelModal: 'Texto',
      saveButton: 'Salvar',
      cancelButton: 'Cancelar',
      notesButtonSegment: 'Notas',
      bankNotesButtonSegment: 'Notas\nBancarias',
      personalAccountsButtonSegment: 'Contas\nPessoais');

  final general = GeneralStrings(
    sucessToast: 'Sucesso!',
    privacyPolicyLabel: 'Política de Privacidade',
    privacyPolicyUrlLabel: 'https://www.google.com.br',
  );

  final validators = ValidatorsStrings(
    invalidUsername: 'Campo Usuário inválido',
    requiredUsername: 'Campo Usuário é obrigatório',
    invalidPassword: 'Senha inválida: Pelo menos 6 caracteres',
    requiredPassword: 'Campo Senha é obrigatório',
    required: 'Campo obrigatório',
  );

  final authError = AuthErrorStrings(
      usernameMessage: 'Username Inválido',
      passwordMessage: 'Password Inválido',
      otherErrorMessage: 'Ocorreu um erro desconhecido',
      emailAlreadyInUseMessage: 'Email já registrado',
      invalidEmailMessage: 'Email Inválido',
      networkRequestFailedMessage: 'Falha na Request devido a rede',
      passwordsDoNotMatchMessage: 'Os campos de senha não estão iguais');

  final noteError = NoteErrorStrings(
      useridNotFoundMessage: 'User Id não encontrado no Armazenamento',
      noteIdNotFoundMessage: 'Nota não encontrada',
      deleteNoteFailMessage: 'Nota não deletada: Note Id não encontrado');

  @override
  StringsI18n get strings {
    return StringsI18n(
        loginPage: loginPage,
        notePage: notePage,
        general: general,
        validators: validators,
        authError: authError,
        noteError: noteError);
  }
}
