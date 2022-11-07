import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mirea_db/api/user_db_role_api.dart';

void main() {
  final userAdmin = MockUser(
    isAnonymous: false,
    uid: 'testMockUID',
  );
  final noUiUser = MockUser(uid: null);

  group('Тестирование апи получения роли юзера', () {
    test('Отправка существующего юзера с ролью admin', () async {
      final fetchRole = await getUserDBRole(userAdmin);
      expect(fetchRole, 'admin');
    });

    test(
        'Если у пользователя нет uid или произошла ошибка запроса, то возвращает error_user',
        () async {
      final fetchRole = await getUserDBRole(noUiUser);
      expect(fetchRole, 'error_user');
    });
  });
  group('Тестирование апи добавления юзера', () {
    //удалять из БД после каждого теста
    final userAddWithUid = MockUser(
      isAnonymous: false,
      uid: 'testUserAdd',
    );
    test('Попытка добавления юзера с uid, должно возвращать true', () async {
      // не должно быть uidtestUserAdd в БД
      final fetchRole = await addUserDBRole(userAddWithUid);
      expect(fetchRole, true);
    });

    test('Попытка добавления юзера без uid, должно возвращать false', () async {
      final auth = MockFirebaseAuth();
      final fetchRole = await addUserDBRole(auth.currentUser);
      expect(fetchRole, false);
    });
  });
}
