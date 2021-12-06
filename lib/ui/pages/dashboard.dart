part of 'pages.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = "/dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Portolink User")),
    body: Column(
      children: [
        Expanded(
          child: SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, MainMenu.routeName);
                },
                child: const Text("Templete View"),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.teal.shade200)),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/catalog');
                },
                child: const Text("Our contact"),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.teal.shade200)),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, MyAccount.routeName);
                },
                child: const Text("My Account"),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.teal.shade200)),
              ),
            ),
          ),
        ),
      ],
     )
    );
  }
}

@override
Widget build(BuildContext context) {

}

