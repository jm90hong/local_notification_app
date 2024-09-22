import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
int id=0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  //todo 권한을 확인하고 요청하는 함수 ios, android 가능.
  Future<void> checkAndRequestNotificationPermission() async {
    // iOS는 permission_handler가 직접 알림 권한을 처리하지 않음
    if (await Permission.notification.isGranted) {
      print('Notification permission already granted.');
    } else if (await Permission.notification.isDenied) {
      // 알림 권한이 거부된 경우 요청
      PermissionStatus status = await Permission.notification.request();
      if (status.isGranted) {
        print('Notification permission granted.');
      } else {
        print('Notification permission denied.');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAndRequestNotificationPermission();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  //todo notification 호출
                  _showNotification();
                },
                child: Text('Notification 호출')
            )
          ],
        ),
      ),
    );
  }
}

//todo notification 호출 함수. -> FCM 백그라운드 메세지 콜백 함수와 연동.
Future<void> _showNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title1', 'plain body2', notificationDetails,
      payload: 'item x');
}