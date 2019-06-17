import 'package:schedule_app/models/schedule_model.dart';
import 'package:schedule_app/repositories/i_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';
import 'base_bloc.dart';

class ScheduleBloc extends BaseBloc {
  final _isLoading = BehaviorSubject<bool>();
  final _listSchedule = BehaviorSubject<List<ScheduleModel>>();

  final IRepository repositorySchedule;

  // retrieve data from stream
  Stream<bool> get isLoading => _isLoading.stream;
  Stream<List<ScheduleModel>> get listSchedule => _listSchedule.stream;

  ScheduleBloc({@required this.repositorySchedule})
      : assert(repositorySchedule != null) {
    //getScheduleList();
  }

  Future getScheduleList() async {
    try {
      this._isLoading.sink.add(true);

      var items = await repositorySchedule.getList();
      if (items != null && items.length > 0) {
        _listSchedule.sink.add(items);
      } else {
        _listSchedule.sink.add([]);
      }

      return items;
    } catch (e) {
      print('error: get Schedule list\n${e.toString()}');
    } finally {
      this._isLoading.sink.add(false);
    }
  }

  dispose() {
    _isLoading.close();
    _listSchedule.close();
  }
}
