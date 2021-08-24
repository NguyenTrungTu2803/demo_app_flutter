import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/models/model.dart';
import 'package:flutter_app_beats/other/other.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/ui/dialogs/dialog.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'package:flutter_app_beats/ui/widgets/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

typedef void CheckData(bool check);

class HotEventPage extends StatefulWidget {
  final int tag;
  final CheckData checkData;
  final int idCategories;
  HotEventPage(
      {required this.tag,required  this.checkData,required  this.idCategories});
  @override
  _HotEventPageState createState() => _HotEventPageState();
}

class _HotEventPageState extends State<HotEventPage> {
  List<DataListEvent>? _dataListEvent;
  ScrollController _scrollController = ScrollController();
  late ListEventItemBLoc _eventItemBLoc;
  int page = 1;
  int tags = 0;
  @override
  void initState() {
    _eventItemBLoc = BlocProvider.of<ListEventItemBLoc>(context);
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent == currentScroll) {
        page++;
        _eventItemBLoc
            .add(ListEventItemFetchedEvent(page: page, id: widget.tag));
      }
    });
    super.initState();
  }
  @override
  void didChangeDependencies() {
    _eventItemBLoc.add(ListEventItemInitEvent());
    tags = widget.idCategories;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(padding: EdgeInsets.only(top: AppBar().preferredSize.height), child: BlocConsumer<ListEventItemBLoc, ListEventItemState>(
        listener: (context, stateL){
          if(stateL is ListEventItemStateInitial){
            LoadingDialog.showLoadingDialog(context);

          }else if(stateL is ListEventItemStateSuccess){
            if(Navigator.of(context).canPop() ){
              Navigator.of(context).pop();
            }
            if(Navigator.of(context).canPop() ){
              Navigator.of(context).pop();
            }
          }

        },
        builder: (context, state) {
          if (state is ListEventItemStateInitial) {
            if (_dataListEvent != null) {
              _dataListEvent!.clear();
              _eventItemBLoc
                  .add(ListEventItemFetchedEvent(id: tags, page: 1));
            } else {
              _eventItemBLoc
                  .add(ListEventItemFetchedEvent(id: widget.tag, page: 1));
            }
            return  ListView.builder(itemBuilder: (context, item)=>Padding(
                padding: AppTheme.paddingTopListViewScreenApp1,
                child: Card(
                  shape: const  RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppTheme.radiusCard1),
                      )),
                  child:Container(
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: AppTheme.white38, width: .5),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(AppTheme.radiusCard1),
                        )),
                    child: Padding(
                      padding:
                      AppTheme.paddingBottomCardListViewScreenApp1,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: width * .65,
                            //width: height*.5,
                            decoration:  const BoxDecoration(
                              color: AppTheme.white38,
                              borderRadius: const BorderRadius.only(
                                  topLeft: const Radius.circular(
                                      AppTheme.radiusCard1),
                                  topRight: const Radius.circular(
                                      AppTheme.radiusCard1)),
                            ),
                          ),
                          Padding(
                            padding:
                            AppTheme.paddingTopScreen,
                            child: Container(
                              height: width * .1,
                              width: height*.9,
                              decoration:  const BoxDecoration(
                                color: AppTheme.white38,
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(
                                        AppTheme.radiusCard1)),
                              ),
                            ),
                          ),
                          Padding(
                              padding: AppTheme.paddingAllScreen1,
                              child: SingleChildScrollView(
                                  scrollDirection:
                                  Axis.horizontal,
                                  child: Row(
                                    children: List.filled(6, true).map((e) => Padding(
                                        padding:
                                        AppTheme.paddingRightScreen,
                                        child: Container(
                                          height: 30,
                                          width: 60,
                                          decoration: const BoxDecoration(
                                              color: AppTheme.white38,
                                              borderRadius: const BorderRadius
                                                  .all(Radius
                                                  .circular(
                                                  AppTheme.radiusAvatar))),
                                        )
                                    )).toList(),
                                  )
                              )),
                          Padding(
                              padding: AppTheme.paddingAllScreen1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: AppTheme.white38,
                                          borderRadius:const
                                          BorderRadius.all(
                                              Radius.circular(
                                                  AppTheme.radiusAvatar)
                                          )
                                      ),
                                      height: AppTheme.heightButton1,),
                                    flex: 8,
                                  ),
                                  const Expanded(
                                    child: const SizedBox(),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration:const BoxDecoration(
                                          color: AppTheme.white38,
                                          borderRadius:const
                                          BorderRadius.all(
                                              Radius.circular(
                                                  AppTheme.radiusAvatar)
                                          )
                                      ),
                                      height: AppTheme.heightButton1,),
                                    flex: 2,
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                )), itemCount: 3,);
          } else if (state is ListEventItemStateSuccess) {
            if (state.list.isEmpty) {
              return Container(
                height: height * .9,
                child: Center(
                  child: Platform.isAndroid
                      ? const CircularProgressIndicator()
                      : const CupertinoActivityIndicator(),
                ),
              );
            }
            return CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                  parent: const AlwaysScrollableScrollPhysics()),
              slivers: <Widget>[
                CupertinoSliverRefreshControl(
                    builder: (_, __, ___, ____, _____) {
                      return Container(
                        child: Center(
                          child: Platform.isAndroid
                              ? const RefreshProgressIndicator(
                            backgroundColor: AppTheme.white38,
                          )
                              : const CupertinoActivityIndicator(
                            radius: 20,
                          ),
                        ),
                      );
                    },
                    refreshTriggerPullDistance: 100.0,
                    refreshIndicatorExtent: 60.0,
                    onRefresh: () async {
                      page = 1;
                      await Future.delayed(Duration(seconds: 3));
                      if (_dataListEvent != null) {
                        _dataListEvent!.clear();
                      }
                      setState(() {
                        _eventItemBLoc.add(ListEventItemRefreshEvent(
                            id: widget.tag, page: page));
                      });

                    }),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        if (index >= state.list.length) {
                          return Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: SizedBox(
                                width: AppTheme.sizeIcon1,
                                height: AppTheme.sizeIcon1,
                                child: Platform.isAndroid
                                    ? const CircularProgressIndicator()
                                    : const CupertinoActivityIndicator(),
                              ),
                            ),
                          );
                        } else {
                          _dataListEvent = state.list;
                          return LayoutBuilder(builder: (context, constraint){
                            if(constraint.maxWidth < 600){
                              return Padding(
                                  padding: AppTheme.paddingTopListViewScreenApp1,
                                  child: Card(
                                    shape:  RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(AppTheme.radiusCard1),
                                        )),
                                    elevation: 5.0,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(SlideLeftTransition(
                                              page: DetailPage(
                                                id: state.list[index].id,
                                                address:
                                                _dataListEvent![index].place.address,
                                                dataEnd: _dataListEvent![index].endedAt,
                                                title: _dataListEvent![index].name,
                                                dateStart: _dataListEvent![index].hostedAt,
                                              )));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border:
                                              Border.all(color: AppTheme.black38, width: .5),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(AppTheme.radiusCard1),
                                              )),
                                          child: Padding(
                                            padding:
                                            AppTheme.paddingBottomCardListViewScreenApp1,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: width * .65,
                                                  decoration:  BoxDecoration(
                                                    borderRadius: const BorderRadius.only(
                                                        topLeft: const Radius.circular(
                                                            AppTheme.radiusCard1),
                                                        topRight: const Radius.circular(
                                                            AppTheme.radiusCard1)),
                                                    image: DecorationImage(
                                                      scale: 80,
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(_dataListEvent![
                                                      index]
                                                          .poster.isNotEmpty
                                                          ? _dataListEvent![index]
                                                          .poster
                                                          : 'https://firebasestorage.googleapis.com/v0/b/fir-c3e15.appspot.com/o/image_beats%2Feven_bg.png?alt=media&token=5eb4f1bf-a6de-4eaa-adde-81d2e1ffe7ca'),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  AppTheme.paddingLeftRightScreenApp1,
                                                  child: Text(
                                                    _dataListEvent![index].name,
                                                    style: AppTheme.title1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  AppTheme.paddingLeftRightTopScreen1,
                                                  child: Text(
                                                    "Sự kiện online",
                                                    style: AppTheme.textRedBold500_1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  AppTheme.paddingLeftRightScreenApp1,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: const Icon(
                                                          Icons.watch_later_rounded,
                                                          color: Colors.red,
                                                          size: AppTheme.sizeIcon1,
                                                        ),
                                                        flex: 1,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${FormatDate.getDateUTC(
                                                            _dataListEvent![index]
                                                                .hostedAt,
                                                            _dataListEvent![index]
                                                                .endedAt,
                                                          )}',
                                                          style: TextStyle(
                                                              fontSize: width * .04,
                                                              fontWeight:
                                                              FontWeight.w800,
                                                              color: Colors.red),
                                                        ),
                                                        flex: 9,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                    padding: AppTheme.paddingAllScreen1,
                                                    child: SingleChildScrollView(
                                                        scrollDirection:
                                                        Axis.horizontal,
                                                        child: Row(
                                                          children: _dataListEvent![index].dataTags.map((e) => Padding(
                                                              padding:
                                                              AppTheme.paddingRightScreen,
                                                              child: MaterialButton(
                                                                elevation: 0.0,
                                                                onPressed: () {},
                                                                height: 30,
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius
                                                                        .all(Radius
                                                                        .circular(
                                                                        AppTheme.radiusAvatar))),
                                                                color: Colors
                                                                    .primaries[
                                                                Random().nextInt(
                                                                    Colors
                                                                        .primaries
                                                                        .length)],
                                                                child: Text(e.name,
                                                                    style: AppTheme.textStyleWhite1),
                                                              )
                                                          )).toList(),
                                                        )
                                                    )),
                                                Padding(
                                                    padding: AppTheme.paddingAllScreen1,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: MaterialButton(
                                                              elevation: 0.0,
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:const
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          AppTheme.radiusAvatar))),
                                                              height: AppTheme.heightButton1,
                                                              color: AppTheme.red,
                                                              onPressed: ()
                                                              {
                                                                showCupertinoModalBottomSheet(
                                                                    barrierColor: Colors.transparent,
                                                                    context: context,
                                                                    builder: (context) =>
                                                                        BuyTicketPage(
                                                                          linkImage: _dataListEvent![
                                                                          index]
                                                                              .poster,
                                                                          dateEnd: _dataListEvent![
                                                                          index]
                                                                              .endedAt,
                                                                          address: _dataListEvent![
                                                                          index]
                                                                              .place
                                                                              .address,
                                                                          id: _dataListEvent![
                                                                          index]
                                                                              .id,
                                                                          dateStart: _dataListEvent![
                                                                          index]
                                                                              .hostedAt, listTicker: [],
                                                                        ));
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  SizedBox(
                                                                    width:
                                                                    10,
                                                                  ),
                                                                  const Text(
                                                                    "Đặt vé trực tuyến",
                                                                    style: AppTheme.textStyleWhite1,
                                                                    textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                  ),
                                                                  const Icon(
                                                                    Icons.check,
                                                                    size: AppTheme.sizeIcon1,
                                                                    color:
                                                                    Colors.white,
                                                                  )
                                                                ],
                                                              )),
                                                          flex: 8,
                                                        ),
                                                        const Expanded(
                                                          child: const SizedBox(),
                                                          flex: 1,
                                                        ),
                                                        Expanded(
                                                          child: MaterialButton(
                                                            elevation: 0.0,
                                                            height: AppTheme.heightButton1,
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius:const
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        AppTheme.radiusAvatar))),
                                                            onPressed: () {
                                                              BottomSheetPop
                                                                  .sharedBottomSheet(
                                                                  context,
                                                                  width,
                                                                  width * .5,
                                                                  _listImage,
                                                                  _listTitleShared,
                                                                      () {});
                                                            },
                                                            color: AppTheme.red,
                                                            child: Icon(
                                                              Icons.reply,
                                                              color: Colors.white,
                                                              size: AppTheme.sizeIcon1,
                                                            ),
                                                          ),
                                                          flex: 2,
                                                        )
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                  ));
                            }else
                              return Padding(
                                  padding: AppTheme.paddingTopListViewScreenApp1,
                                  child: Card(
                                    shape:  RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(AppTheme.radiusCard1),
                                        )),
                                    elevation: 5.0,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(SlideLeftTransition(
                                              page: DetailPage(
                                                id: state.list[index].id,
                                                address:
                                                _dataListEvent![index].place.address,
                                                dataEnd: _dataListEvent![index].endedAt,
                                                title: _dataListEvent![index].name,
                                                dateStart: _dataListEvent![index].hostedAt,
                                              )));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border:
                                              Border.all(color: AppTheme.black38, width: .5),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(AppTheme.radiusCard1),
                                              )),
                                          child: Padding(
                                            padding:
                                            AppTheme.paddingBottomCardListViewScreenApp1,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: width * .65,
                                                  decoration:  BoxDecoration(
                                                    borderRadius: const BorderRadius.only(
                                                        topLeft: const Radius.circular(
                                                            AppTheme.radiusCard1),
                                                        topRight: const Radius.circular(
                                                            AppTheme.radiusCard1)),
                                                    image: DecorationImage(
                                                      scale: 80,
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(_dataListEvent![
                                                      index]
                                                          .poster.isNotEmpty
                                                          ? _dataListEvent![index]
                                                          .poster
                                                          : 'https://firebasestorage.googleapis.com/v0/b/fir-c3e15.appspot.com/o/image_beats%2Feven_bg.png?alt=media&token=5eb4f1bf-a6de-4eaa-adde-81d2e1ffe7ca'),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  AppTheme.paddingLeftRightScreenApp1,
                                                  child: Text(
                                                    _dataListEvent![index].name,
                                                    style: AppTheme.title2,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  AppTheme.paddingLeftRightScreenApp1,
                                                  child: Text(
                                                    "Sự kiện online",
                                                    style: AppTheme.textRedBold500_2,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: const Icon(
                                                        Icons.watch_later_rounded,
                                                        color: Colors.red,
                                                        size: AppTheme.sizeIcon2,
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${FormatDate.getDateUTC(
                                                          _dataListEvent![index]
                                                              .hostedAt ,
                                                          _dataListEvent![index]
                                                              .endedAt ,
                                                        )}',
                                                        style: TextStyle(
                                                            fontSize: width * .04,
                                                            fontWeight:
                                                            FontWeight.w800,
                                                            color: Colors.red),
                                                      ),
                                                      flex: 9,
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                    padding: AppTheme.paddingAllScreen2,
                                                    child: SingleChildScrollView(
                                                        scrollDirection:
                                                        Axis.horizontal,
                                                        child: Row(
                                                          children: _dataListEvent![index].dataTags.map((e) => Padding(
                                                              padding:
                                                              AppTheme.paddingRightScreen,
                                                              child: MaterialButton(
                                                                elevation: 0.0,
                                                                onPressed: () {},
                                                                height: 60.0,
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius
                                                                        .all(Radius
                                                                        .circular(
                                                                        AppTheme.radiusAvatar))),
                                                                color: Colors
                                                                    .primaries[
                                                                Random().nextInt(
                                                                    Colors
                                                                        .primaries
                                                                        .length)],
                                                                child: Text(e.name,
                                                                    style: AppTheme.textStyleWhite2),
                                                              )
                                                          )).toList(),
                                                        )
                                                    )),
                                                Padding(
                                                    padding: AppTheme.paddingAllScreen1,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: MaterialButton(
                                                              elevation: 0.0,
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:const
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          AppTheme.radiusAvatar))),
                                                              height: AppTheme.heightButton2,
                                                              color: AppTheme.red,
                                                              onPressed: ()
                                                              {
                                                                showCupertinoModalBottomSheet(
                                                                    barrierColor: Colors.transparent,
                                                                    context: context,
                                                                    builder: (context) =>
                                                                        BuyTicketPage(
                                                                          linkImage: _dataListEvent![
                                                                          index]
                                                                              .poster,
                                                                          dateEnd: _dataListEvent![
                                                                          index]
                                                                              .endedAt,
                                                                          address: _dataListEvent![
                                                                          index]
                                                                              .place
                                                                              .address,
                                                                          id: _dataListEvent![
                                                                          index]
                                                                              .id,
                                                                          dateStart: _dataListEvent![
                                                                          index]
                                                                              .hostedAt, listTicker: [],
                                                                        ));
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  SizedBox(
                                                                    width:
                                                                    10,
                                                                  ),
                                                                  const Text(
                                                                    "Đặt vé trực tuyến",
                                                                    style: AppTheme.textStyleWhite2,
                                                                    textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                  ),
                                                                  const Icon(
                                                                    Icons.check,
                                                                    size: AppTheme.sizeIcon2,
                                                                    color:
                                                                    Colors.white,
                                                                  )
                                                                ],
                                                              )),
                                                          flex: 8,
                                                        ),
                                                        const Expanded(
                                                          child: const SizedBox(),
                                                          flex: 1,
                                                        ),
                                                        Expanded(
                                                          child: MaterialButton(
                                                            elevation: 0.0,
                                                            height: AppTheme.heightButton2,
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius:const
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        AppTheme.radiusAvatar))),
                                                            onPressed: () {
                                                              BottomSheetPop
                                                                  .sharedBottomSheet(
                                                                  context,
                                                                  width,
                                                                  width * .5,
                                                                  _listImage,
                                                                  _listTitleShared,
                                                                      () {});
                                                            },
                                                            color: AppTheme.red,
                                                            child: Icon(
                                                              Icons.reply,
                                                              color: Colors.white,
                                                              size: AppTheme.sizeIcon2,
                                                            ),
                                                          ),
                                                          flex: 2,
                                                        )
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                  ));
                          });
                        }
                      },
                      childCount: state.hasReachedEnd
                          ? state.list.length
                          : state.list.length + 1,
                    ))
              ],
            );
          } else {
            return Text('Loading...');
          }
        },
      ),));

  }
  final List<String> _listImage = <String>[
    "assets/image/facebook_shared_icon.png",
    "assets/image/messenger_shared_icon.png",
    "assets/image/twitter_shared_icon.png"
  ];
  final List<String> _listTitleShared = <String>[
    "Facebook",
    "Messenger",
    "Twitter"
  ];

  final List<String> titleButton = <String>[
    "Công nghệ",
    "Online",
    "Video trực tuyến"
  ];
}
