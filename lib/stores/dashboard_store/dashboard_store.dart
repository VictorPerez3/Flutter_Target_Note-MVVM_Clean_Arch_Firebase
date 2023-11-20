import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dashboard_store.g.dart';

class DashboardStore = _DashboardStore with _$DashboardStore;

abstract class _DashboardStore with Store {
  @observable
  ObservableList<Item> items = ObservableList<Item>();

  @observable
  int? editingItemId;

  @observable
  bool isTextFieldFocused = false;

  _DashboardStore() {
    _loadItems();
  }

  @action
  void setTextFieldFocus(bool isFocused) {
    isTextFieldFocused = isFocused;
  }

  @action
  Future<void> handleSubmit(String value) async {
    if (value.isNotEmpty) {
      if (editingItemId != null) {
        await editItem(editingItemId!, value);
      } else {
        await addItem(value);
      }
      setEditingItem(null);
    }
  }

  @action
  Future<void> addItem(String text) async {
    final newItem = Item(id: DateTime.now().millisecondsSinceEpoch, text: text);
    items.add(newItem);
    await _saveItems();
  }

  @action
  Future<void> removeItem(int id) async {
    items.removeWhere((item) => item.id == id);
    await _saveItems();
  }

  @action
  void setEditingItem(int? id) {
    editingItemId = id;
  }

  @action
  Future<void> editItem(int id, String newText) async {
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      items[index] = Item(id: id, text: newText);
      await _saveItems();
    }
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? itemsString = prefs.getString('items');
    if (itemsString != null) {
      final List<dynamic> jsonList = json.decode(itemsString);
      items = ObservableList.of(jsonList.map((json) => Item.fromJson(json)));
    } else {
      // Carregar dados padrões se não houver dados salvos
      items = ObservableList.of([
        Item(id: 1, text: "cachorro"),
        Item(id: 2, text: "gato"),
      ]);
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonList =
        json.encode(items.map((item) => item.toJson()).toList());
    await prefs.setString('items', jsonList);
  }
}

class Item {
  final int id;
  final String text;

  Item({required this.id, required this.text});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(id: json['id'], text: json['text']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text};
  }
}
