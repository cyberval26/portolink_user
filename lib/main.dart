

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portolink_user/ui/pages/pages.dart';
import 'package:portolink_user/ui/widgets/widgets.dart';

void enablePlatformOverrideForDesktop(){
  if (!kIsWeb &&(Platform.isMacOS|| Platform.isWindows ||Platform.isLinux)){
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

  void main() async{
    enablePlatformOverrideForDesktop();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  }

/*void main() {
  runApp(const MyApp());
}*/

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portolink',
      initialRoute: '/splash',
      routes : {
        Splash.routeName  : (context) => Splash(),
        Login.routeName : (context) => Login(),
        //'/': (context) => Login(),
         MainMenu.routeName : (context) => MainMenu(),
        Register.routeName : (context) => Register(),
        TemplateView.routeName : (context) => TemplateView(),
        Dashboard.routeName : (context) => Dashboard(),
        AccountView.routeName : (context) => AccountView(),
        MyAccount.routeName : (context) => MyAccount(),
        OrderTemplate.routeName :(context) => OrderTemplate(),
        ListTemplate.routeName :(context) => ListTemplate(),
        PendingRequest.routeName :(context) => PendingRequest(),
      },
    );
  }
}
