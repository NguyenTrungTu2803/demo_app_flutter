import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_beats/bases/route/name_route.dart';
import 'package:flutter_app_beats/blocs/detail_event_bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/models/detail/detail_event_model.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/other/model/received_notification.dart';
import 'package:flutter_app_beats/other/other.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/ui/dialogs/dialog.dart';
import 'package:flutter_app_beats/ui/pages/detail_page/describe_tickets.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'package:flutter_app_beats/ui/widgets/widget.dart';
import 'package:flutter_app_beats/utils/notification_plugin_util.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_app_beats/utils/toast_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DetailPage extends StatefulWidget {
  final int id;
  final String address;
  final String title;
  final String dateStart;
  final String dataEnd;
  DetailPage(
      {Key? key,
        required this.title,
        required this.dateStart,
        required this.dataEnd,
        required this.id,
        required this.address})
      : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with AutomaticKeepAliveClientMixin<DetailPage> {
  int indexDescribe = 0;
  bool checkValida = false;
  bool _isNotification = false;
  bool _isFollow = false;
  String? lat;
  String? lng;
  DetailEventBloc? _detailEventBloc;
  DetailEventModel? detailEventModel;
  @override
  void initState() {
    // detailEventModel = DetailEventModel(status: 1, );
    //initLocalNotification();
    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
    _detailEventBloc = BlocProvider.of<DetailEventBloc>(context);
    _detailEventBloc!.add(DetailStartEvent(id: widget.id));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, cons) {
      if (cons.maxWidth < 600) {
        return Scaffold(
          appBar: AppBar(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppTheme.red,
                statusBarIconBrightness: Brightness.light),
            backgroundColor: AppTheme.red,
            centerTitle: true,
            title: Text(
              widget.title,
              style: AppTheme.titleAppBar1,
            ),
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.menu_sharp,
                    color: Colors.white,
                    size: AppTheme.sizeIcon1,
                  ),
                  onPressed: () {})
            ],
          ),
          body: SingleChildScrollView(
            physics: Platform.isAndroid
                ? const ClampingScrollPhysics()
                : const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              child: BlocConsumer<DetailEventBloc, DetailState>(
                listener: (context, stateL) {
                  if (stateL is DetailStateSuccess) {
                    if(_isFollow){
                      ToastUtil.showToastDefault('Bạn đã theo dõi sự kiện nè!');
                    }
                  }
                  else if (stateL is CreateFollowErrorState || stateL is DeleteFollowErrorState) {
                    IOSDialog.showDialogLogout(
                        context, 'Bạn vui lòng đăng nhập lại?', () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          loginPage, (Route<dynamic> route) => false);
                      SharedPreferencesUtil.clear();
                    });
                  }
                },
                builder: (context, state) {
                  if (state is DetailStateFetched) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Platform.isAndroid
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(AppTheme.red),
                              )
                            : const CupertinoActivityIndicator(),
                      ),
                    );
                  }
                  if (state is DetailStateSuccess) {
                    var dataList = state.eventModel;
                    if(dataList.userFollows.length> 0){
                      for(int i =0; i< dataList.userFollows.length; i++){
                        if(dataList.userFollows[i].email == SharedPreferencesUtil.getString(email)){
                          _isFollow = true;
                          break;
                        }else{
                          _isFollow = false;
                        }
                      }
                    }
                    print(_isFollow.toString() + 'fff');
                    return Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          height: width * .5,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(dataList.poster != null
                                      ? dataList.poster
                                      : "https://firebasestorage.googleapis.com/v0/b/fir-c3e15.appspot.com/o/image_beats%2Fbeats_solo_bg.png?alt=media&token=4cc210c6-297a-469b-94d9-d41c01e771e3"))),
                        ),
                        Padding(
                            padding: AppTheme.paddingAllScreen1,
                            child: Text(
                              widget.title,
                              style: AppTheme.title1,
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      height: AppTheme.heightButton1,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  AppTheme.radiusAvatar))),
                                      onPressed: () =>
                                          BottomSheetPop.sharedBottomSheet(
                                              context,
                                              width,
                                              width * .5,
                                              _listImage,
                                              _listTitleShared,
                                              () {}),
                                      color: AppTheme.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.reply,
                                            color: Colors.white,
                                            size: AppTheme.sizeIcon1,
                                          ),
                                          const Text("Share",
                                              textAlign: TextAlign.center,
                                              style: AppTheme.textStyleWhite1),
                                          const SizedBox(),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  width: width * .05,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      height: AppTheme.heightButton1,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  AppTheme.radiusAvatar))),
                                      onPressed: () {
                                        if(dataList.userFollows.length == 0){
                                          _detailEventBloc!.add(CreateFollowFetchedEvent(followableId: widget.id, followableType: 1));
                                          _isFollow = true;
                                        }
                                        else if(_isFollow) {
                                          // _detailEventBloc.add(
                                          //     DeleteFollowFetchedEvent(
                                          //         id: 13,));
                                          ToastUtil.showToastDefault('Bạn hủy theo dõi sự kiện nè!');
                                          _isFollow = !_isFollow;
                                        }
                                        //
                                        // }else if(!_isFollow && dataList.userFollows.length>0){
                                        //   ToastUtil.showToastDefault('Bạn đã hủy follow sự kiện nè');
                                        //   _isFollow = true;
                                        // }
                                        setState(() {
                                        });
                                        print(_isFollow);
                                      },
                                      color: AppTheme.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          _isFollow ? const Icon(
                                            Icons.star_outlined,
                                            color: AppTheme.black38,
                                            size: AppTheme.sizeIcon1,
                                          ) :const Icon(
                                            Icons.star_outlined,
                                            color: AppTheme.white,
                                            size: AppTheme.sizeIcon1,
                                          ),
                                          const Text(
                                            "Interested",
                                            textAlign: TextAlign.center,
                                            style: AppTheme.textStyleWhite1,
                                          ),
                                          const SizedBox(),
                                        ],
                                      ),
                                    ))
                              ],
                            )),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Expanded(
                                  child: const Icon(
                                    Icons.watch_later_rounded,
                                    color: AppTheme.red,
                                    size: AppTheme.sizeIcon1,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${FormatDate.getDateUTC(
                                            widget.dateStart ,
                                            widget.dataEnd ,
                                          )}',
                                          style: AppTheme.textRedBold500_1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(
                                      _isNotification
                                          ? Icons.notifications_active
                                          : Icons.notifications_active_outlined,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _isNotification = !_isNotification;
                                      });
                                      if (_isNotification) {
                                        await notificationPlugin
                                            .scheduleNotification(
                                                0, 'title', 'body', 5);
                                        ToastUtil.showToastDefault(
                                            "Đã đặt thông báo cho sự kiện này");
                                      } else {
                                        await notificationPlugin
                                            .cancelNotification(0);
                                        ToastUtil.showToastDefault(
                                            "Đã hủy sự kiện nè");
                                      }
                                    },
                                  ),
                                  flex: 1,
                                )
                              ],
                            )),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: const Icon(
                                      Icons.edit_location,
                                      size: AppTheme.sizeIcon1,
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Container(
                                      width: width * .85,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              SlideLeftTransition(
                                                  page: GoogleMapPage(
                                                    address: '',
                                                lat: double.parse(
                                                    dataList.place.lat),
                                                long: double.parse(
                                                    dataList.place.long),
                                              )));
                                        },
                                        child: Text(
                                          "Công Khai: ${widget.address}",
                                          overflow: TextOverflow.visible,
                                          style: AppTheme.captionBlack1,
                                        ),
                                      )),
                                )
                              ],
                            )),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: const Icon(
                                        Icons.language,
                                        size: AppTheme.sizeIcon1,
                                        color: AppTheme.black,
                                      )),
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Container(
                                    child: const Text(
                                      "Đơn vị tổ chức do Beats Solo tổ chức",
                                      style: AppTheme.subtitle1,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: const Icon(
                                      Icons.missed_video_call_rounded,
                                      size: AppTheme.sizeIcon1,
                                      color: AppTheme.black,
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Container(
                                    child: const Text(
                                      "Diễn ra trực tiếp tại Facebook Live",
                                      overflow: TextOverflow.visible,
                                      style: AppTheme.subtitle1,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                          padding: AppTheme.paddingLeftRightTopScreen1,
                          child: Container(
                              width: width,
                              height: width * .6,
                              child: ListView.builder(
                                  semanticChildCount: 1,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dataList.speakers != null
                                      ? dataList.speakers.length
                                      : linkImage.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => DetailSpeakerPage(
                                                    name: dataList
                                                        .speakers[index].name,
                                                    description: dataList
                                                        .speakers[index]
                                                        .description,
                                                    dob: dataList
                                                        .speakers[index].dob,
                                                    position: dataList
                                                        .speakers[index].title,
                                                    index: index,
                                                    linkAvatar: dataList
                                                        .speakers[index].avatar,
                                                  ))),
                                      child: Container(
                                        width: width * .45,
                                        child: Card(
                                          elevation: 1.0,
                                          child: Column(
                                            children: <Widget>[
                                              Hero(
                                                tag: index,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(dataList
                                                                      .speakers[
                                                                          index]
                                                                      .avatar !=
                                                                  null
                                                              ? dataList
                                                                  .speakers[
                                                                      index]
                                                                  .avatar
                                                              : linkImage[
                                                                  index])),
                                                      borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(
                                                              AppTheme
                                                                  .radiusCard1),
                                                          topRight: Radius.circular(
                                                              AppTheme.radiusCard1))),
                                                  // width: width * .35,
                                                  height: width * .4,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    AppTheme.paddingTopScreen,
                                                child: Text(
                                                  dataList.speakers[index]
                                                              .name !=
                                                          null
                                                      ? dataList
                                                          .speakers[index].name
                                                      : nameAvatar[index],
                                                  textAlign: TextAlign.center,
                                                  style: AppTheme.captionBlack1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                  dataList.speakers[index]
                                                              .title !=
                                                          null
                                                      ? dataList
                                                          .speakers[index].title
                                                      : positionAvatar[index],
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      AppTheme.captionBlack1),
                                            ],
                                          ),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      AppTheme.radiusCard1))),
                                        ),
                                      ),
                                    );
                                  })),
                        ),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dataList.description != null
                                    ? dataList.description
                                    : "Apple đã tung ra một mẫu tai nghe on-ear mới thuộc thương hiệu có tên Beats có tên Beast Solo Pro. Đây là một chiếc tới nghe on-ear quen thuộc có khã năng cống ồn mạnh mẽ. Cho những ai biết thì chiếc Beats Solo Pro này chính là chiếc Solo 4 Wireless được đổi tên để phù hợp kiểu dáng hơn với chiếc Powerbeats Pro và thậm chí là cả iphone 11Pro/Pro Max nữa.",
                                style: AppTheme.captionBlack1,
                                textAlign: TextAlign.start,
                              ),
                            )),
                        DescribeTickets(
                          dataTickets: dataList.listTickets,
                        ),
                        Padding(
                          padding: AppTheme.paddingLeftRightTopScreen1,
                          child: MaterialButton(
                              height: AppTheme.heightButton1,
                              minWidth: width,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(AppTheme.radiusAvatar))),
                              onPressed: () {
                                showCupertinoModalBottomSheet(
                                    elevation: 0.0,
                                    barrierColor: Colors.transparent,
                                    //useRootNavigator: true,
                                    //enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return BuyTicketPage(
                                        id: 0,
                                        linkImage: dataList.poster,
                                        dateEnd: widget.dataEnd,
                                        address: widget.address,
                                        listTicker: dataList.listTickets,
                                        dateStart: widget.dateStart,
                                      );
                                    });
                              },
                              color: AppTheme.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const SizedBox(),
                                  Text(
                                    FormatDate.getDateDay(
                                                dataList.discountedFrom,
                                                dataList.discountedTo) >
                                            0
                                        ? 'Còn ${FormatDate.getDateDay(dataList.discountedFrom, dataList.discountedTo)} ngày nữa để đặt vé giảm ${dataList.discount}%'
                                        : "Tiến hành đặt vé",
                                    style: AppTheme.textStyleWhite1,
                                  ),
                                  const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: AppTheme.sizeIcon1,
                                  )
                                ],
                              )),
                        ),
                      ],
                    );
                  }
                  else{
                    return Container();
                  }
                  // else {
                  //   return Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Center(
                  //       child: Platform.isAndroid
                  //           ? CircularProgressIndicator(
                  //               valueColor: AlwaysStoppedAnimation<Color>(
                  //                   Colors.redAccent),
                  //             )
                  //           : CupertinoActivityIndicator(),
                  //     ),
                  //   );
                  // }
                },
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppTheme.red,
                statusBarIconBrightness: Brightness.light),
            backgroundColor: AppTheme.red,
            centerTitle: true,
            title: Text(
              widget.title,
              style: AppTheme.titleAppBar2,
            ),
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.menu_sharp,
                    color: Colors.white,
                    size: AppTheme.sizeIcon2,
                  ),
                  onPressed: () {})
            ],
          ),
          body: SingleChildScrollView(
            physics: Platform.isAndroid
                ? const ClampingScrollPhysics()
                : const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 40),
            child: Container(
              child: BlocBuilder<DetailEventBloc, DetailState>(
                builder: (context, state) {
                  if (state is DetailEventFetchEvent) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Platform.isAndroid
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(AppTheme.red),
                              )
                            : const CupertinoActivityIndicator(),
                      ),
                    );
                  }
                  if (state is DetailStateSuccess) {
                    var dataList = state.eventModel;
                    return Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          height: width * .5,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(dataList.poster != null
                                      ? dataList.poster
                                      : "https://firebasestorage.googleapis.com/v0/b/fir-c3e15.appspot.com/o/image_beats%2Fbeats_solo_bg.png?alt=media&token=4cc210c6-297a-469b-94d9-d41c01e771e3"))),
                        ),
                        Padding(
                            padding: AppTheme.paddingAllScreen2,
                            child: Text(
                              widget.title,
                              style: AppTheme.title2,
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      height: AppTheme.heightButton2,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  AppTheme.radiusAvatar))),
                                      onPressed: () =>
                                          BottomSheetPop.sharedBottomSheet(
                                              context,
                                              width,
                                              width * .5,
                                              _listImage,
                                              _listTitleShared,
                                              () {}),
                                      color: AppTheme.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.reply,
                                            color: Colors.white,
                                            size: AppTheme.sizeIcon2,
                                          ),
                                          const Text("Share",
                                              textAlign: TextAlign.center,
                                              style: AppTheme.textStyleWhite2),
                                          const SizedBox(),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  width: width * .05,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: MaterialButton(
                                      height: AppTheme.heightButton2,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  AppTheme.radiusAvatar))),
                                      onPressed: () {},
                                      color: AppTheme.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.star_outlined,
                                            color: AppTheme.white,
                                            size: AppTheme.sizeIcon2,
                                          ),
                                          const Text(
                                            "Interested",
                                            textAlign: TextAlign.center,
                                            style: AppTheme.textStyleWhite2,
                                          ),
                                          const SizedBox(),
                                        ],
                                      ),
                                    ))
                              ],
                            )),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Expanded(
                                  child: const Icon(
                                    Icons.watch_later_rounded,
                                    color: AppTheme.red,
                                    size: AppTheme.sizeIcon2,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${FormatDate.getDateUTC(
                                            widget.dateStart,
                                            widget.dataEnd ,
                                          )}',
                                          style: AppTheme.textRedBold500_2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(
                                      _isNotification
                                          ? Icons.notifications_active
                                          : Icons.notifications_active_outlined,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _isNotification = !_isNotification;
                                      });
                                      if (_isNotification) {
                                        await notificationPlugin
                                            .scheduleNotification(
                                                0, 'title', 'body', 5);
                                        ToastUtil.showToastDefault(
                                            "Đã đặt thông báo cho sự kiện này");
                                      } else {
                                        await notificationPlugin
                                            .cancelNotification(0);
                                        ToastUtil.showToastDefault(
                                            "Đã hủy sự kiện nè");
                                      }
                                    },
                                  ),
                                  flex: 1,
                                )
                              ],
                            )),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: const Icon(
                                      Icons.edit_location,
                                      size: AppTheme.sizeIcon2,
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Container(
                                      width: width * .85,
                                      child: GestureDetector(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              SlideLeftTransition(
                                                  page: GoogleMapPage(
                                                    address: '',
                                                lat: double.parse(
                                                    dataList.place.lat),
                                                long: double.parse(
                                                    dataList.place.long),
                                              )));
                                        },
                                        child: Text(
                                          "Công Khai: ${widget.address}",
                                          overflow: TextOverflow.visible,
                                          style: AppTheme.captionBlack2,
                                        ),
                                      )),
                                )
                              ],
                            )),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: const Icon(
                                        Icons.language,
                                        size: AppTheme.sizeIcon2,
                                        color: AppTheme.black,
                                      )),
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Container(
                                    child: const Text(
                                      "Đơn vị tổ chức do Beats Solo tổ chức",
                                      style: AppTheme.subtitle2,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: const Icon(
                                      Icons.missed_video_call_rounded,
                                      size: AppTheme.sizeIcon2,
                                      color: AppTheme.black,
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Container(
                                    child: const Text(
                                      "Diễn ra trực tiếp tại Facebook Live",
                                      overflow: TextOverflow.visible,
                                      style: AppTheme.subtitle2,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                          padding: AppTheme.paddingLeftRightTopScreen2,
                          child: Container(
                              width: width,
                              height: width * .6,
                              child: ListView.builder(
                                  semanticChildCount: 1,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dataList.speakers != null
                                      ? dataList.speakers.length
                                      : linkImage.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => DetailSpeakerPage(
                                                    name: dataList
                                                        .speakers[index].name,
                                                    description: dataList
                                                        .speakers[index]
                                                        .description,
                                                    dob: dataList
                                                        .speakers[index].dob,
                                                    position: dataList
                                                        .speakers[index].title,
                                                    index: index,
                                                    linkAvatar: dataList
                                                        .speakers[index].avatar,
                                                  ))),
                                      child: Container(
                                        width: width * .45,
                                        child: Card(
                                          elevation: 1.0,
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 4,
                                                child: Hero(
                                                  tag: index,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(dataList
                                                                        .speakers[
                                                                            index]
                                                                        .avatar !=
                                                                    null
                                                                ? dataList
                                                                    .speakers[
                                                                        index]
                                                                    .avatar
                                                                : linkImage[
                                                                    index])),
                                                        borderRadius: const BorderRadius.only(
                                                            topLeft: Radius.circular(
                                                                AppTheme
                                                                    .radiusCard1),
                                                            topRight:
                                                                Radius.circular(
                                                                    AppTheme.radiusCard1))),
                                                    // width: width * .35,
                                                    height: width * .4,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Text(
                                                    dataList.speakers[index]
                                                                .name !=
                                                            null
                                                        ? dataList
                                                            .speakers[index]
                                                            .name
                                                        : nameAvatar[index],
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        AppTheme.captionBlack2,
                                                    overflow:
                                                        TextOverflow.visible,
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                    dataList.speakers[index]
                                                                .title !=
                                                            null
                                                        ? dataList
                                                            .speakers[index]
                                                            .title
                                                        : positionAvatar[index],
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style:
                                                        AppTheme.captionBlack2),
                                              ),
                                            ],
                                          ),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      AppTheme.radiusCard1))),
                                        ),
                                      ),
                                    );
                                  })),
                        ),
                        Padding(
                            padding: AppTheme.paddingLeftRightTopScreen2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dataList.description != null
                                    ? dataList.description
                                    : "Apple đã tung ra một mẫu tai nghe on-ear mới thuộc thương hiệu có tên Beats có tên Beast Solo Pro. Đây là một chiếc tới nghe on-ear quen thuộc có khã năng cống ồn mạnh mẽ. Cho những ai biết thì chiếc Beats Solo Pro này chính là chiếc Solo 4 Wireless được đổi tên để phù hợp kiểu dáng hơn với chiếc Powerbeats Pro và thậm chí là cả iphone 11Pro/Pro Max nữa.",
                                style: AppTheme.captionBlack2,
                                textAlign: TextAlign.start,
                              ),
                            )),
                        DescribeTickets(
                          dataTickets: dataList.listTickets,
                        ),
                        Padding(
                          padding: AppTheme.paddingLeftRightTopScreen2,
                          child: MaterialButton(
                              height: AppTheme.heightButton2,
                              minWidth: width,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(AppTheme.radiusAvatar))),
                              onPressed: () {
                                showCupertinoModalBottomSheet(
                                    elevation: 0.0,
                                    barrierColor: Colors.transparent,
                                    //useRootNavigator: true,
                                    //enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return BuyTicketPage(
                                        linkImage: dataList.poster,
                                        dateEnd: widget.dataEnd,
                                        address: widget.address,
                                        listTicker: dataList.listTickets,
                                        dateStart: widget.dateStart, id: 0,
                                      );
                                    });
                              },
                              color: AppTheme.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const SizedBox(),
                                  Text(
                                    FormatDate.getDateDay(
                                                dataList.discountedFrom,
                                                dataList.discountedTo ) >
                                            0
                                        ? 'Còn ${FormatDate.getDateDay(dataList.discountedFrom, dataList.discountedTo)} ngày nữa để đặt vé giảm ${dataList.discount}%'
                                        : "Tiến hành đặt vé",
                                    style: AppTheme.textStyleWhite2,
                                  ),
                                  const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: AppTheme.sizeIcon1,
                                  )
                                ],
                              )),
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Platform.isAndroid
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.redAccent),
                              )
                            : CupertinoActivityIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      }
    });
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
  final List<String> linkImage = <String>[
    "https://firebasestorage.googleapis.com/v0/b/fir-c3e15.appspot.com/o/image_beats%2Fjimmylovine.png?alt=media&token=028f83ee-3f16-46ba-bd4f-f3b0f6c5145f",
  ];
  final List<String> nameAvatar = <String>[
    "JIMMY LOVINE",
  ];
  final List<String> positionAvatar = <String>[
    "C.E.0 BEATS SOLO",
  ];
  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {}
  onNotificationClick(String payload) {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
//dispose trong khi pop or push thi luu lai sharedPreferences trang thai dem toi bao nhieu
}
