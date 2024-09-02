// import 'package:flutter_project_target/presentation/stores/xxx-home_store/xxx-note_store.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dashboard_test.mocks.dart';
//
// @GenerateMocks([SharedPreferences])
// void main() {
//   group('DashboardStore Tests', () {
//     late MockSharedPreferences mockSharedPreferences;
//
//     setUp(() {
//       mockSharedPreferences = MockSharedPreferences();
//       SharedPreferences.setMockInitialValues({});
//     });
//
//     test('Initial list is empty', () {
//       when(mockSharedPreferences.getString(any)).thenReturn(null);
//       final dashboardStore = DashboardStore();
//       expect(dashboardStore.notes, isEmpty);
//     });
//
//     test('Add item to the list', () async {
//       when(mockSharedPreferences.getString(any)).thenReturn(null);
//       final dashboardStore = DashboardStore();
//       await dashboardStore.addNote('Test Item');
//       expect(dashboardStore.notes.length, equals(1));
//       expect(dashboardStore.notes.first.text, equals('Test Item'));
//     });
//
//     test('Edit an item in the list', () async {
//       when(mockSharedPreferences.getString(any)).thenReturn(null);
//       final dashboardStore = DashboardStore();
//       await dashboardStore.addNote('Test Item');
//       int itemId = dashboardStore.notes.first.id;
//       await dashboardStore.editItem(itemId, 'Updated Item');
//       expect(dashboardStore.notes.first.text, equals('Updated Item'));
//     });
//
//     test('Remove an item from the list', () async {
//       when(mockSharedPreferences.getString(any)).thenReturn(null);
//       final dashboardStore = DashboardStore();
//       await dashboardStore.addNote('Test Item');
//       int itemId = dashboardStore.notes.first.id;
//       await dashboardStore.removeNote(itemId);
//       expect(dashboardStore.notes, isEmpty);
//     });
//   });
// }
