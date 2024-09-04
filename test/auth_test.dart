// import 'package:flutter_project_target/core/base/constants/auth/auth.string.dart';
// import 'package:flutter_project_target/core/base/dal/storage/storage_interface.dart';
// import 'package:flutter_project_target/core/base/utils/enum.util.dart';
// import 'package:flutter_project_target/core/resources/auth/mock/dal/datasource/auth_datasource_interface.dart';
// import 'package:flutter_project_target/features/stores/login_store/xxx-auth_store.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
//
// class MockAuthDataSource extends Mock implements IAuthDataSource {}
//
// class MockStorage extends Mock implements IStorage {}
//
// void main() {
//   group('AuthStore Tests', () {
//     late AuthStore authStore;
//     late MockAuthDataSource mockAuthDataSource;
//     late MockStorage mockStorage;
//
//     setUp(() {
//       mockAuthDataSource = MockAuthDataSource();
//       mockStorage = MockStorage();
//       authStore = AuthStore(mockAuthDataSource, mockStorage);
//     });
//
//     test('Initial values are empty', () {
//       expect(authStore.username, '');
//       expect(authStore.password, '');
//     });
//
//     test('Username and password validation', () {
//       authStore.setUsername(strMockUsername1);
//       authStore.setPassword(strMockPassword1);
//       expect(authStore.isValid, isTrue);
//
//       authStore.setUsername('auth');
//       authStore.setPassword('1');
//       expect(authStore.isValid, isFalse);
//     });
//
//     // test('Login with valid credentials returns success', () async {
//     //   authStore.setUsername(strMockUsername1);
//     //   authStore.setPassword(strMockPassword1);
//     //   final result = await authStore.authenticate();
//     //   expect(result, AuthenticateStatus.success);
//     // });
//     //
//     // test('Login with invalid credentials returns error', () async {
//     //   authStore.setUsername('invalid');
//     //   authStore.setPassword('invalid');
//     //   final result = await authStore.authenticate();
//     //   expect(result, AuthenticateStatus.invalidUser);
//     // });
//   });
// }
