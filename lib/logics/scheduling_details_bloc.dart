import 'package:schedule_app/models/schedule_model.dart';
import 'package:schedule_app/repositories/i_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'base_bloc.dart';

class SchedulingDetailsBloc extends BaseBloc {
  final _isLoading = BehaviorSubject<bool>();

  final _newObj = BehaviorSubject<bool>();
  final _ok = BehaviorSubject<bool>();
  final _startDate = BehaviorSubject<DateTime>();
  final _endDate = BehaviorSubject<DateTime>();
  TextEditingController txtDescription;

  ScheduleModel schedule;

  final IRepository repositorySchedule;

  // retrieve data from stream
  Stream<bool> get isLoading => _isLoading.stream;
  Stream<bool> get newObj => _newObj.stream;
  Stream<bool> get ok => _ok.stream;
  Stream<DateTime> get startDate => _startDate.stream;
  Stream<DateTime> get endDate => _endDate.stream;

  SchedulingDetailsBloc({@required this.repositorySchedule, this.schedule})
      : assert(repositorySchedule != null) {
    if (this.schedule == null) {
      this.schedule = ScheduleModel();
      this.schedule.ok = false;
      // new object
      this._newObj.sink.add(true);
    }

    txtDescription = TextEditingController(text: this.schedule.description);

    setOk(schedule.ok);
    setStartDate(schedule.startDate);
    setEndDate(schedule.endDate);
  }

  bool setStartDate(DateTime value) {
    _startDate.sink.add(value);
    this.schedule.startDate = value;

    return true;
  }

  bool setEndDate(DateTime value) {
    _endDate.sink.add(value);
    this.schedule.endDate = value;

    return true;
  }

  bool setOk(bool value) {
    _ok.sink.add(value);
    this.schedule.ok = value;

    return true;
  }

  Future<bool> save() async {
    try {
      this._isLoading.sink.add(true);
      this.schedule.description = txtDescription.text;

      if (this.schedule.id == null) {
        var uuid = new Uuid();
        this.schedule.id = uuid.v1();
        await repositorySchedule.insertObject(schedule);
      } else {
        await repositorySchedule.updateObject(this.schedule.id, this.schedule);
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      this._isLoading.sink.add(false);
    }
  }

  Future<bool> delete() async {
    try {
      this._isLoading.sink.add(true);
      this.schedule.description = txtDescription.text;

      await repositorySchedule.deleteObject(this.schedule.id);
      return true;
    } catch (e) {
      return false;
    } finally {
      this._isLoading.sink.add(false);
    }
  }

  dispose() {
    _isLoading.close();
    _ok.close();
  }
}
