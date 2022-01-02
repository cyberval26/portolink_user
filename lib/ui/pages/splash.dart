part of 'pages.dart';

class Splash extends StatefulWidget {
  static const String routeName = "/splash";
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  _loadSplash() async{
    var _duration = Duration(seconds: 3);
     return Timer(_duration,checkAuth);
  }

   void checkAuth(){
     //Navigator.pushReplacementNamed(context, Login.routeName);
     FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null){
      Navigator.pushReplacementNamed(context, MainMenu.routeName);
      ActivityServices.showToast("Welcome Back " +auth.currentUser.email, Colors.green[600]);
    }else{
      Navigator.pushReplacementNamed(context, Login.routeName);
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          alignment: Alignment.center,
          child:Column(
              children:  [
               Image.asset("assets/images/portolink.png", height: 400
                ),
               /* Text("Portolink", style: TextStyle(
                  fontSize: 24,
                  color: Colors.tealAccent,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                )),*/
              ]
          )
      ),
    );
  }
}