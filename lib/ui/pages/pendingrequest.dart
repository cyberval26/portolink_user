part of 'pages.dart';

class PendingRequest extends StatefulWidget {
  static const String routeName = "/pendingrequest";

  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Request"),
      leading: IconButton(icon:Icon(Icons.arrow_back),
      onPressed:() =>  Navigator.pushReplacementNamed(context, Dashboard.routeName),
        // centerTitle: true,
      )),
     // resizeToAvoidBottomInset: false ,
    );
  }
}
