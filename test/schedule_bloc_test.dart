import 'package:schedule_app/logics/schedule_bloc.dart';
import 'package:schedule_app/models/schedule_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import 'schedule_repository_test.dart';

class MockScheduleBloc extends Mock implements ScheduleBloc {}

main() {
  MockScheduleRepository mockRepository;
  ScheduleBloc bloc;

  setUp(() {
    mockRepository = MockScheduleRepository();
    bloc = ScheduleBloc(repositorySchedule: mockRepository);
  });

  group('getList', () {
    test('Should return Schedule List', () async {
      // Use Mockito to return a successful list when it calls the
      // provided mehod getList.
      when(bloc.getScheduleList()).thenAnswer((_) async => [
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

      expect(await bloc.getScheduleList(), isInstanceOf<List<ScheduleModel>>());
    });
  });
}
