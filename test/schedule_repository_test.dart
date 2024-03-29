import 'package:schedule_app/models/schedule_model.dart';
import 'package:schedule_app/repositories/i_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

class MockScheduleRepository extends Mock implements IRepository {}

main() {
  MockScheduleRepository repository;
  setUp(() {
    repository = MockScheduleRepository();
  });

  group('getList', () {
    test('Should return Schedule List', () async {
      when(repository.getList()).thenAnswer((_) async => [
            ScheduleModel(
                id: '111111',
                description: 'Test',
                startDate: DateTime.now(),
                endDate: DateTime.now().add(Duration(hours: 1)),
                ok: false),
            ScheduleModel(
                id: '222222',
                description: 'Test',
                startDate: DateTime.now(),
                endDate: DateTime.now().add(Duration(hours: 1)),
                ok: true),
          ]);

      expect(await repository.getList(), isInstanceOf<List<ScheduleModel>>());
    });
  });

  group('getObject', () {
    test('Should return Schedule Object', () async {
      when(await repository.getObject('1')).thenAnswer((_) async =>
          ScheduleModel(
              id: '1',
              description: 'Test',
              startDate: DateTime.now(),
              endDate: DateTime.now().add(Duration(hours: 1)),
              ok: false));

      expect(await repository.getObject('1'), isInstanceOf<ScheduleModel>());
    });
  });

  group('insertObject', () {
    test('Should return Schedule Object inserted', () async {
      when(repository.insertObject(ScheduleModel())).thenAnswer((_) async =>
          ScheduleModel(
              id: '1',
              description: 'Test',
              startDate: DateTime.now(),
              endDate: DateTime.now().add(Duration(hours: 1)),
              ok: false));

      expect(await repository.insertObject(isInstanceOf<ScheduleModel>()),
          isInstanceOf<ScheduleModel>());
    });
  });

  group('updateObject', () {
    test('Should return Schedule Object updated', () async {
      when(repository.updateObject('1', ScheduleModel())).thenAnswer(
          (_) async => ScheduleModel(
              id: '1',
              description: 'Test',
              startDate: DateTime.now(),
              endDate: DateTime.now().add(Duration(hours: 1)),
              ok: false));

      expect(await repository.updateObject('1', isInstanceOf<ScheduleModel>()),
          isInstanceOf<ScheduleModel>());
    });
  });

  group('deleteObject', () {
    test('Should return true indicating that the deletion occurred', () async {
      when(repository.deleteObject('1')).thenAnswer((_) async => true);

      expect(await repository.deleteObject('1'), true);
    });
  });

  group('clean', () {
    test('Should return true indicating that the cleanup has occurred',
        () async {
      when(repository.clean()).thenAnswer((_) async => true);

      expect(await repository.clean(), true);
    });
  });
}
