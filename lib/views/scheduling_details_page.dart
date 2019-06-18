import 'package:schedule_app/helpers/util.dart';
import 'package:schedule_app/logics/scheduling_details_bloc.dart';
import 'package:schedule_app/models/schedule_model.dart';
import 'package:schedule_app/repositories/schedule_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:schedule_app/widgets/button_widget.dart';

class SchedulingDetailsPage extends StatefulWidget {
  SchedulingDetailsPage({Key key, this.schedule}) : super(key: key);

  final ScheduleModel schedule;

  @override
  _SchedulingDetailsPageState createState() =>
      _SchedulingDetailsPageState(this.schedule);
}

class _SchedulingDetailsPageState extends State<SchedulingDetailsPage> {
  SchedulingDetailsBloc _bloc;

  _SchedulingDetailsPageState(this.schedule);
  final ScheduleModel schedule;

  void _handleSave() async {
    var resp = await _bloc.save();
    if (resp) {
      Navigator.pop(context);
    }
  }

  void _handleDel() async {
    var resp = await _bloc.delete();
    if (resp) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    _bloc = SchedulingDetailsBloc(
      repositorySchedule: ScheduleRepository(),
      schedule: this.schedule,
    );

    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scheduling Details',
          key: Key('titleSchedulingDetails'),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                      width: 90.0,
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Flexible(
                    child: StreamBuilder<DateTime>(
                      stream: _bloc.startDate,
                      initialData: null,
                      builder: (context, it) {
                        return FlatButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              showTitleActions: true,
                              onChanged: _bloc.setStartDate,
                              onConfirm: _bloc.setStartDate,
                              currentTime: it.data,
                              locale: LocaleType.pt,
                            );
                          },
                          child: Text(
                            Util.showDateTime(it.data, '<Select date>'),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                      width: 90.0,
                      child: Text(
                        'End',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Flexible(
                    child: StreamBuilder<DateTime>(
                      stream: _bloc.endDate,
                      initialData: null,
                      builder: (context, it) {
                        return FlatButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              showTitleActions: true,
                              onChanged: _bloc.setEndDate,
                              onConfirm: _bloc.setEndDate,
                              currentTime: it.data,
                              locale: LocaleType.pt,
                            );
                          },
                          child: Text(
                            Util.showDateTime(it.data, '<Select date>'),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      key: Key('textFieldDescription'),
                      controller: _bloc.txtDescription,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.0,
                          horizontal: 20.0,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 90.0,
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: StreamBuilder<bool>(
                      stream: _bloc.ok,
                      initialData: false,
                      builder: (context, snapshot) {
                        return Switch(
                          key: Key('switchOk'),
                          value: snapshot.data,
                          onChanged: _bloc.setOk,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<bool>(
              stream: _bloc.newObj,
              initialData: false,
              builder: (context, it) {
                return Offstage(
                  offstage: it.data,
                  child: ButtonWidget(
                    key: Key('buttonRemove'),
                    handle: _handleDel,
                    icon: Icon(
                      Icons.delete,
                    ),
                    title: 'Delete',
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('buttonSave'),
        onPressed: _handleSave,
        tooltip: 'Save',
        child: Icon(Icons.save),
      ),
    );
  }
}
