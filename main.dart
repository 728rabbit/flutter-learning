import 'package:flutter/material.dart';
import 'helper.dart';
import 'login.dart';
import 'home.dart';

Map<String, dynamic>? authedUser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initPushNotifincation();
  authedUser = await getSession('authedUser');
  print(authedUser);
  runApp(MyApp()); 
}

void initPushNotifincation() {
  /*
  // Enable verbose logging for debugging (remove in production)
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // Initialize with your OneSignal App ID
  OneSignal.initialize("4f85b70a-7c35-4937-b8ce-68526d0f4944");
  // Use this method to prompt for push notifications.
  // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
  OneSignal.Notifications.requestPermission(false);*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ((authedUser?.isNotEmpty == true) ?'/home':'/login'),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => MyHomePage(title: 'Home'),
      }
    );
  }
}

