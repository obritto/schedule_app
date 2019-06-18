import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function handle;

  const ButtonWidget({
    Key key,
    @required this.title,
    @required this.icon,
    this.handle,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: handle,
          child: Row(
            children: <Widget>[
              this.icon,
              Text(
                this.title,
              )
            ],
          ),
        ),
      ],
    );
  }
}
