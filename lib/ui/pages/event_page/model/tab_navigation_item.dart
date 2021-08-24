import 'package:flutter/cupertino.dart';

import '../hot_event_page.dart';
import '../my_event_page.dart';
import '../online_event_page.dart';
import '../this_week_event_page.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  TabNavigationItem({required this.page, required this.title});

  static List<TabNavigationItem> items(BuildContext context) =>[
    //TabNavigationItem(page: HotEventPage(), title: Text("Hot")),
    TabNavigationItem(page: ThisWeekEventPage(), title: Text("This week")),
    TabNavigationItem(page: OnlineEventPage(), title: Text("Online")),
    TabNavigationItem(page: MyEventPage(), title: Text("My events")),
  ];


}
