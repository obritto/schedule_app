import 'package:flutter/widgets.dart';
import 'package:schedule_app/helpers/util.dart';
import 'package:schedule_app/logics/schedule_bloc.dart';
import 'package:schedule_app/models/schedule_model.dart';
import 'package:schedule_app/repositories/schedule_repository.dart';
import 'package:schedule_app/views/scheduling_details_page.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  ScheduleBloc _bloc;

  void _handleAddSchedule() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SchedulingDetailsPage(),
      ),
    );

    _bloc.getScheduleList();
  }

  void _handleTapSchedule(ScheduleModel schedule) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SchedulingDetailsPage(schedule: schedule),
      ),
    );

    _bloc.getScheduleList();
  }

  @override
  void initState() {
    _bloc = ScheduleBloc(
      repositorySchedule: ScheduleRepository(),
    );
    _bloc.getScheduleList();
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
          'Schedule',
          key: Key('titleSchedule'),
        ),
      ),
      body:
          //Container(),
          Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StreamBuilder<List<ScheduleModel>>(
            stream: _bloc.listSchedule,
            initialData: [],
            builder: (context, listSchedule) {
              return Flexible(
                child: ClipRect(
                  child: listSchedule.data.length == 0
                      ? Container(
                          child: Center(
                            child: Text('Without scheduling'),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 15.0),
                          itemCount: listSchedule.data.length,
                          itemBuilder: (_, index) {
                            return _buildSchedule(
                              listSchedule.data[index],
                            );
                          },
                        ),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('buttonAdd'),
        onPressed: _handleAddSchedule,
        tooltip: 'Add',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildSchedule(ScheduleModel schedule) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 3.0,
      ),
      child: FlatButton(
        key: Key("textFieldDescription"),
        onPressed: () => _handleTapSchedule(
              schedule,
            ),
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.calendar_today,
                  size: 25,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      schedule.description == null ||
                              schedule.description.isEmpty
                          ? 'No description'
                          : schedule.description,
                      style: TextStyle(
                        color:
                            (schedule.ok == true) ? Colors.green : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      Util.showDateTime(schedule.startDate, 'No date'),
                      style: TextStyle(
                        color:
                            (schedule.ok == true) ? Colors.green : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      Util.showDateTime(schedule.endDate, 'No date'),
                      style: TextStyle(
                        color:
                            (schedule.ok == true) ? Colors.green : Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
