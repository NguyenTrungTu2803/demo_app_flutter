import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpTicketDialog<T> extends PageRoute<T> {
  final WidgetBuilder _builder;
  final bool barrier;
  HelpTicketDialog(
      {required WidgetBuilder builder,
      RouteSettings? settings,
      required this.barrier,
      bool fullScreenDialog = false})
      : _builder = builder,
        super(
          settings: settings,
          fullscreenDialog: fullScreenDialog,
        );
  @override
  bool get opaque => false;
  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => barrier;
  @override
  // TODO: implement maintainState
  bool get maintainState => false;
  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(milliseconds: 0);
  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.transparent;
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => "Thong tin";
}
