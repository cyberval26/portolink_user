import 'package:flutter/material.dart';
import 'package:portolink_user/ui/pages/pages.dart';
import 'package:portolink_user/ui/widgets/widgets.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portolink',
      initialRoute: '/splash',
      routes : {
        Splash.routeName  : (context) => Splash(),
        Login.routeName : (context) => Login(),
        //'/': (context) => Login(),
        // MainMenu.routeName : (context) => MainMenu(),
        Register.routeName : (context) => Register(),
        TemplateView.routeName : (context) => TemplateView(),
        Dashboard.routeName : (context) => Dashboard(),
        AccountView.routeName : (context) => AccountView(),
      },
    );
  }
}
