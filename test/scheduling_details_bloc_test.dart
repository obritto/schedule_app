import 'package:schedule_app/logics/scheduling_details_bloc.dart';
import 'package:schedule_app/models/schedule_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import 'schedule_repository_test.dart';

class MockSchedulingDetailsBloc extends Mock implements SchedulingDetailsBloc {}

main() {
  MockScheduleRepository mockRepository;
  SchedulingDetailsBloc bloc;

  setUp(() {
    mockRepository = MockScheduleRepository();
    bloc = SchedulingDetailsBloc(repositorySchedule: mockRepository);
  });

  group('save', () {
    test('Should return true indicating that the Schedule Object has inserted',
        () async {
      var schedule = ScheduleModel();
      when(bloc.save()).thenAnswer((_) async {
        if (schedule.id == null) {
          schedule.id = '1';
          await mockRepository.insertObject(schedule);
        } else {
          await mockRepository.updateObject(schedule.id, schedule);
        }
        return true;
      });

      expect(await bloc.save(), true);
      bloc.dispose();
    });

    test('Should return true indicating that the Schedule Object has updated',
        () async {
      var schedule = ScheduleModel(id: '1');
      when(bloc.save()).thenAnswer((_) async {
        if (schedule.id == null) {
          schedule.id = '1';
          await mockRepository.insertObject(schedule);
        } else {
          await mockRepository.updateObject(schedule.id, schedule);
        }
        return true;
      });

      expect(await bloc.save(), true);
      bloc.dispose();
    });
  });

  group('delete', () {
    test('Should return true indicating that the Schedule Object has removed',
        () async {
      when(bloc.delete()).thenAnswer((_) async {
        await mockRepository.deleteObject('1');
        return true;
      });

      expect(await bloc.save(), true);
      bloc.dispose();
    });
  });
}
