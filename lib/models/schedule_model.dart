class ScheduleModel extends Object {
  ScheduleModel(
      {this.id, this.startDate, this.endDate, this.description, this.ok});

  String id;
  DateTime startDate;
  DateTime endDate;
  String description;
  bool ok;

  static fromJson(Map<String, dynamic> json) {
    final model = ScheduleModel();

    model.id = json['id'] as String;
    model.startDate = (json['startDate'] == null || json['startDate'] == '')
        ? null
        : DateTime.parse(json['startDate'] as String);
    model.endDate = (json['endDate'] == null || json['endDate'] == '')
        ? null
        : DateTime.parse(json['endDate'] as String);
    model.description = json['description'];

    if (json['ok'].toString() == "true") {
      model.ok = true;
    } else {
      model.ok = false;
    }

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['startDate'] = this.startDate?.toIso8601String();
    data['endDate '] = this.endDate?.toIso8601String();
    data['descricao'] = this.description;
    data['ok'] = this.ok;

    return data;
  }
}
