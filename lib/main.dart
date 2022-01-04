import 'dart:io';
import 'package:firebase_core/firebase_core.dart';  
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portolink_user/shared/shared.dart';
import 'package:portolink_user/ui/pages/pages.dart';
import 'package:portolink_user/ui/widgets/widgets.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}
void main() async {
  enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme(),
      initialRoute: '/splash',
      routes: {
        Splash.routeName: (context) => const Splash(),
        Login.routeName: (context) => const Login(),
        Register.routeName: (context) => const  Register(),
        MainMenu.routeName: (context) => const MainMenu(),
        TemplateView.routeName: (context) => const TemplateView(),
        Dashboard.routeName: (context) => Dashboard(),
      },
    );
  }
}