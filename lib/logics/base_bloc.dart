import 'package:flutter/material.dart';

class BaseBloc {
  BuildContext context;

  void configContext(BuildContext currentContext) {
    context = currentContext;
  }
}
