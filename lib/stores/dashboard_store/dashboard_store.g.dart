// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardStore on _DashboardStore, Store {
  late final _$itemsAtom =
      Atom(name: '_DashboardStore.items', context: context);

  @override
  ObservableList<Item> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<Item> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$editingItemIdAtom =
      Atom(name: '_DashboardStore.editingItemId', context: context);

  @override
  int? get editingItemId {
    _$editingItemIdAtom.reportRead();
    return super.editingItemId;
  }

  @override
  set editingItemId(int? value) {
    _$editingItemIdAtom.reportWrite(value, super.editingItemId, () {
      super.editingItemId = value;
    });
  }

  late final _$isTextFieldFocusedAtom =
      Atom(name: '_DashboardStore.isTextFieldFocused', context: context);

  @override
  bool get isTextFieldFocused {
    _$isTextFieldFocusedAtom.reportRead();
    return super.isTextFieldFocused;
  }

  @override
  set isTextFieldFocused(bool value) {
    _$isTextFieldFocusedAtom.reportWrite(value, super.isTextFieldFocused, () {
      super.isTextFieldFocused = value;
    });
  }

  late final _$handleSubmitAsyncAction =
      AsyncAction('_DashboardStore.handleSubmit', context: context);

  @override
  Future<void> handleSubmit(String value) {
    return _$handleSubmitAsyncAction.run(() => super.handleSubmit(value));
  }

  late final _$addItemAsyncAction =
      AsyncAction('_DashboardStore.addItem', context: context);

  @override
  Future<void> addItem(String text) {
    return _$addItemAsyncAction.run(() => super.addItem(text));
  }

  late final _$removeItemAsyncAction =
      AsyncAction('_DashboardStore.removeItem', context: context);

  @override
  Future<void> removeItem(int id) {
    return _$removeItemAsyncAction.run(() => super.removeItem(id));
  }

  late final _$editItemAsyncAction =
      AsyncAction('_DashboardStore.editItem', context: context);

  @override
  Future<void> editItem(int id, String newText) {
    return _$editItemAsyncAction.run(() => super.editItem(id, newText));
  }

  late final _$_DashboardStoreActionController =
      ActionController(name: '_DashboardStore', context: context);

  @override
  void setTextFieldFocus(bool isFocused) {
    final _$actionInfo = _$_DashboardStoreActionController.startAction(
        name: '_DashboardStore.setTextFieldFocus');
    try {
      return super.setTextFieldFocus(isFocused);
    } finally {
      _$_DashboardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEditingItem(int? id) {
    final _$actionInfo = _$_DashboardStoreActionController.startAction(
        name: '_DashboardStore.setEditingItem');
    try {
      return super.setEditingItem(id);
    } finally {
      _$_DashboardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
editingItemId: ${editingItemId},
isTextFieldFocused: ${isTextFieldFocused}
    ''';
  }
}
