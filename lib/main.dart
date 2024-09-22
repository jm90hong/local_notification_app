import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification_app/screen/home_screen.dart';


//todo 초기 notification 세팅.-> 사용 안함.
void initNotification() async{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
}




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  _initNotiSetting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

//todo 초기 notification 세팅.
Future<void> _initNotiSetting() async {
  //Notification 플로그인 객체 생성
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //안드로이드 초기 설정
  final AndroidInitializationSettings initSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  // IOS 초기 설정(권한 요청도 할 수 있음)
  // request...값을 true로 설정 시 앱이 켜지자마자 권한 요청을 함
  final DarwinInitializationSettings initSettingsIOS =
  DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true
  );

  //Notification에 위에서 설정한 안드로이드, IOS 초기 설정 값 삽입
  final InitializationSettings initSettings = InitializationSettings(
    android: initSettingsAndroid,
    iOS: initSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
  );
  //Notification 초기 설정
  //onSelectNotification 옵션을 넣어서 메세지를 누르면 작동되는 콜백 함수를 생성 할 수 있다.(안써도됨)
  //안쓰게되면 해당 노티 클릭시 앱을 그냥 실행한다.
  //await flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification:[콜백] );
}
