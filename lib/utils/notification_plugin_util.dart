import 'dart:io';
import 'dart:ui';
import 'package:flutter_app_beats/other/model/received_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationPluginUtil {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification>
      _didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  var initializationSettings;
  NotificationPluginUtil._() {
    init();
  }
  init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    initializePlatformSpecifics();
  }

  initializePlatformSpecifics() {
    var initializationSettingAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettingIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        //
        ReceivedNotification receivedNotification = ReceivedNotification(
            id: id, title: title.toString(), body: body.toString(), payload: payload.toString());
        _didReceivedLocalNotificationSubject.add(receivedNotification);
      },
    );
    initializationSettings = InitializationSettings(
      android:initializationSettingAndroid,
      iOS:initializationSettingIOS,
    );
  }

  void _requestIOSPermission() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        !.requestPermissions(alert: false, badge: false, sound: true);
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    _didReceivedLocalNotificationSubject.listen((value) {
      onNotificationInLowerVersions(value);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification(int id, String title, String body, int sec) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
    importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var isoChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: isoChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        id, "titleTest", "bodyTest", platformChannelSpecifics,

        payload: "payloadTest");
  }
  Future<void> scheduleNotification(int id, String title, String body, int seconds) async {
    var scheduleNotificationDataTime = DateTime.now().add(Duration(seconds: seconds));
    var androidChannelSpecifics = AndroidNotificationDetails(
      "channelId1", "channelName1", "channelDescription1",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
      //icon: "secondary_icon",
      largeIcon: DrawableResourceAndroidBitmap('@drawable/launch_background'),
      //sound: RawResourceAndroidNotificationSound("my_sound"),
      enableLights: true,
      ledOnMs: 1000,
      ledOffMs: 500,
      color: const Color.fromARGB(66, 165, 245, 1),// background
      ledColor: const Color.fromARGB(66, 165, 245, 1),
    );
    var isoChannelSpecifics = IOSNotificationDetails(
      //sound: 'my_sound.aiff'
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: isoChannelSpecifics);
    await _flutterLocalNotificationsPlugin.schedule(
        id, title, body,
        scheduleNotificationDataTime,
        platformChannelSpecifics,

        payload: "payloadTest");
  }
  Future<void> cancelNotification(int id) async{
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
  Future<void> cancelAllNotification() async{
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}

NotificationPluginUtil notificationPlugin = NotificationPluginUtil._();
