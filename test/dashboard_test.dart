import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_test.mocks.dart';
import 'package:flutter_project_target/stores/dashboard_store/dashboard_store.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('DashboardStore Tests', () {
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      SharedPreferences.setMockInitialValues({});
    });

    test('Initial list is empty', () {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final dashboardStore = DashboardStore();
      expect(dashboardStore.items, isEmpty);
    });

    test('Add item to the list', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final dashboardStore = DashboardStore();
      await dashboardStore.addItem('Test Item');
      expect(dashboardStore.items.length, equals(1));
      expect(dashboardStore.items.first.text, equals('Test Item'));
    });

    test('Edit an item in the list', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final dashboardStore = DashboardStore();
      await dashboardStore.addItem('Test Item');
      int itemId = dashboardStore.items.first.id;
      await dashboardStore.editItem(itemId, 'Updated Item');
      expect(dashboardStore.items.first.text, equals('Updated Item'));
    });

    test('Remove an item from the list', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final dashboardStore = DashboardStore();
      await dashboardStore.addItem('Test Item');
      int itemId = dashboardStore.items.first.id;
      await dashboardStore.removeItem(itemId);
      expect(dashboardStore.items, isEmpty);
    });
  });
}
