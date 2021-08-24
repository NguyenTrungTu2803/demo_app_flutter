import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_beats/blocs/event_categories_bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'package:flutter_app_beats/ui/widgets/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
    with AutomaticKeepAliveClientMixin<EventPage> {
  late EventCategoriesBloc _categoriesBloc;

  int tags = 1;

  @override
  void initState() {
    _categoriesBloc = BlocProvider.of<EventCategoriesBloc>(context);
    _categoriesBloc.add(EventCategoriesStartEvent());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppTheme.red,
              statusBarIconBrightness: Brightness.light),
          backgroundColor: AppTheme.red,
          title: const Text(
            "Events",
            style: AppTheme.titleAppBar1,
          ),
          actions: [
              PopupMenu.popupMenuCheckTicket(context, width)
          ],
        ),
        body: BlocBuilder<EventCategoriesBloc, EventCategoriesState>(
            builder: (context, state) {
          if (state is EventCategoriesStateInit) {
            return Container(
              height: AppBar().preferredSize.height,
              width: width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index)=>Padding(padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: AppBar().preferredSize.height,
                  width: 100,
                  decoration: BoxDecoration(
                      color: AppTheme.white38,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                ),)
                , itemCount: 6,),
            );
          }
          if (state is EventCategoriesStateSuccess) {
            return DefaultTabController(
              length: state.listEventCategories.length,
              child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  tags = state.listEventCategories[0].id;

                  return <Widget>[
                    SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          backgroundColor: AppTheme.background,
                          floating: true, pinned: true, snap: false,
                          title: TabBar(
                            onTap: (tag) {
                              tags = state.listEventCategories[tag].id;
                              //_eventItemBLoc.add(ListEventItemInitEvent());
                            },
                            physics: Platform.isIOS
                                ? BouncingScrollPhysics()
                                : ClampingScrollPhysics(),
                            enableFeedback: false,
                            indicatorColor: Colors.black,
                            isScrollable: true,
                            tabs: state.listEventCategories
                                .map(
                                  (data) => Tab(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(data.name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: width*.04,
                                                fontWeight: FontWeight.bold))),
                                  ),
                                )
                                .toList(),
                          ),
                        )),
                  ];
                },
                body: TabBarView(
                  physics: Platform.isAndroid? ClampingScrollPhysics():BouncingScrollPhysics(),
                  children:
                  state.listEventCategories.map((name) {
                    return Builder(
                      builder: (BuildContext context) {
                        return NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification) {
                              return true;
                            },
                            child: Padding(
                              padding: AppTheme.paddingLeftRightScreenApp1,
                              child: HotEventPage(
                                  //eventItemBLoc: _eventItemBLoc,
                                  idCategories: name.id,
                                  tag: tags,
                                checkData: (bool check) {  },
                              ),
                            ));
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return Text('');
          }
        }));
  }

  @override
  bool get wantKeepAlive => true;
}
